require("full-border"):setup{
  type = ui.Border.ROUNDED,
}

-- require("no-status"):setup()

require("simple-status"):setup()

require("yatline"):setup({
	show_background = true,
	display_header_line = false,
	display_status_line = true
})
