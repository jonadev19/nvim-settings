return {
	-- Hihglight colors
	{
		"nvim-mini/mini.hipatterns",
		event = "BufReadPre",
		opts = {},
	},
	{
		"telescope.nvim",
		priority = 1000,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			-- ... (tus otros atajos ;f, ;r, etc. se mantienen igual)
			{
				"sf",
				function()
					local telescope = require("telescope")
					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = vim.fn.expand("%:p:h"),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal", -- Inicia en modo normal para usar 'a'
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = telescope.extensions.file_browser.actions

			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				wrap_results = true,
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			})

			opts.extensions = {
				file_browser = {
					theme = "dropdown",
					hijack_netrw = true,
					mappings = {
						["n"] = {
							-- SOLUCIÓN: Usamos 'a' para crear. 'N' siempre dará error E486 en modo normal.
							["a"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end, -- Volver a búsqueda rápido
						},
						["i"] = {
							-- También permitimos crear archivos con Ctrl+a si estás escribiendo
							["<C-a>"] = fb_actions.create,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
	},
}
