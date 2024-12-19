M = {}

local function get_dictionary()
	local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h")
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

M.generate_spellfile = function()
	-- Create spell_dir if it doesn't exist
	vim.fn.mkdir(get_spell(true), "p")
	vim.cmd("mkspell! " .. get_spell() .. " " .. get_dictionary())
end

M.test = function()
	print(M.config.add)
end

local add_lang = function(lang)
	local current = vim.opt.spelllang:get()
	if not vim.tbl_contains(current, lang) then
		table.insert(current, lang)
	end
	vim.opt.spelllang = current
end

local function check_build()
	local stat_plug = vim.uv.fs_stat(get_dictionary())
	local stat_spell = vim.uv.fs_stat(get_spell() .. ".utf-8.spl") or vim.uv.fs_stat(get_spell() .. ".ascii.spl")
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

M.config = {
	add = true,
}

local function load()
	if M.config.add then
		-- print("add true")
		-- We generate the spellfile if it doesn't exist
		if check_build() then
			M.generate_spellfile()
		end
		add_lang("en-academic")
	else
		-- print("add false")
	end
end

-- TODO: create a `once` autocmd to execute load() on VimEnter?

M.setup = function(opts)
	M.config = vim.tbl_extend("force", M.config, opts or {})
	-- print(opts.add)
	-- load()
	-- return M
end

load()

return M
