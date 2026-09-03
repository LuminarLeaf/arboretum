vim.lsp.config("nixd", {
	settings = {
		nixd = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
})
