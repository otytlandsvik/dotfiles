-- Extra init configuration for nixvim config

-- Timeout before keybind is triggered
vim.opt.timeoutlen = 250

-- Define Commands to enable/disable format on save
-- from https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable only for current buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat on save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function(args)
	if args.bang then
		-- FormatEnable! will enable only for current buffer
		vim.b.disable_autoformat = false
	else
		vim.g.disable_autoformat = false
	end
end, {
	desc = "Enable autoformat on save",
	bang = true,
})
