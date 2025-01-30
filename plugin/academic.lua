-- schedule required to let opts merge
vim.schedule(require("academic").load)
vim.api.nvim_create_user_command("AcademicUpdate", function()
	require("academic").update()
end, {})
vim.api.nvim_create_user_command("AcademicBuild", function()
	require("academic").generate_spellfile("Building spellfile...")
end, {})
