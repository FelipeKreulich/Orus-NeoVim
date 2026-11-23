-- Inline colour preview. catgoose/nvim-colorizer.lua is the maintained fork of norcalli's
-- (the original is abandoned and triggered the vim.tbl_flatten deprecation warning).
return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPost",
	opts = {
		filetypes = { "*" },
		user_default_options = {
			RGB = true,
			RRGGBB = true,
			RRGGBBAA = true,
			names = false,
			css = true,
			css_fn = true,
			tailwind = true,
		},
	},
}
