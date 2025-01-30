M = {}

---@class AcademicOptions
M.opts = {
	auto_install = true,
	auto_rebuild = false,
}

local function get_root()
	return vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h")
end

local function get_dictionary()
	local root = get_root()
	local dict_path = root .. "/words/en-academic"
	return dict_path
end

local function get_spell(dir)
	local spell_dir = vim.fn["spellfile#WritableSpellDir"]() .. "/"
	if dir then
		return spell_dir
	else
		return spell_dir .. "en-academic"
	end
end

---@param msg string # Message to show user before generation.
M.generate_spellfile = function(msg)
	vim.notify("Academic: " .. msg)
	-- Create spell_dir if it doesn't exist
	vim.fn.mkdir(get_spell(true), "p")
	vim.cmd("mkspell! " .. get_spell() .. " " .. get_dictionary())
	vim.notify("Academic: Done!")
end

local add_lang = function(lang)
	local current = vim.opt.spelllang:get()
	if not vim.tbl_contains(current, lang) then
		table.insert(current, lang)
	end
	vim.opt.spelllang = current
end

local function get_spl_stat()
	return vim.uv.fs_stat(get_spell() .. ".utf-8.spl") or vim.uv.fs_stat(get_spell() .. ".ascii.spl")
end

local function check_build()
	local stat_plug = vim.uv.fs_stat(get_dictionary())
	local stat_spell = get_spl_stat()
	if not stat_plug then
		vim.notify("Academic wordlist missing!", vim.log.levels.ERROR)
		return false
	else
		if not stat_spell then
			return true
		end
	end
	-- helper function for time comparison
	local function time(stat)
		return stat.mtime.sec + stat.mtime.nsec * 1e-9
	end
	-- compare whether our wordlist is newer than user's generated one
	if time(stat_plug) > time(stat_spell) then
		return true
	else
		return false
	end
end

M.update = function()
	local cmd = { "bash", "-c", get_root() .. "/scripts/generate-wordlist.sh" }
	local success = pcall(function()
		vim.system(cmd, {}, function()
			vim.notify("Academic dictionary updated!", vim.log.levels.INFO)
		end)
	end)
	if not success then
		vim.notify("Manual update requires bash, curl, and hunspell!", vim.log.levels.WARN)
	end
	M.load()
end

M.load = function()
	-- We generate the spellfile if it doesn't exist
	if M.opts.auto_install and not get_spl_stat() then
		M.generate_spellfile("No spellfile, installing now...")
	elseif M.opts.auto_rebuild and check_build() then
		M.generate_spellfile("Spellfile out of date, rebuilding now...")
	end
	add_lang("en-academic")
end

M.setup = function(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

return M
