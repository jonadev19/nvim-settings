return {
	{
		"rest-nvim/rest.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		ft = "http",
		config = function()
			require("rest-nvim").setup({
				-- Mantenemos tus preferencias originales:
				result_split_horizontal = false, -- División vertical
				result_split_in_place = false,
				stay_in_current_window_after_split = false,
				skip_ssl_verification = false,
				encode_url = true,
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					show_url = true,
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					show_statistics = false,
					formatters = {
						json = "jq", -- Tu formateador JSON
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				jump_to_request = false,
				env_file = ".env", -- Tu soporte para variables de entorno
				custom_dynamic_variables = {},
				yank_dry_run = true,
				search_back = true,
			})
		end,
		keys = {
			{
				"\\r",
				"<cmd>Rest run<cr>", -- El comando moderno para ejecutar
				desc = "Test the current file",
			},
		},
	},
}
