require("academic").load()
vim.api.nvim_create_user_command("AcademicUpdate", require("academic").update, {})
vim.api.nvim_create_user_command("AcademicBuild", require("academic").generate_spellfile, {})
