return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true, -- Mantenemos tu preferencia de fondo transparente
			flavour = "mocha", -- Puedes elegir entre: latte, frappe, macchiato, mocha
			integrations = {
				nvimtree = true,
				telescope = {
					enabled = true,
				},
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- Otras integraciones basadas en tus archivos:
				neotest = true,
				noice = true,
				bufferline = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
