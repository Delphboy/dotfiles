return {
	black = 0xff181819,
	white = 0xff657b83, -- Text / base00
	red = 0xffdc322f,
	green = 0xff859900,
	blue = 0xff268bd2,
	yellow = 0xffb58900,
	orange = 0xffcb4b16,
	magenta = 0xffcb4b16,
	grey = 0xff657b83, -- Non-active logos / base00
	transparent = 0x00000000,

	bar = {
		bg = 0xfffdf6e3, -- base3
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xfffdf6e3, -- base3
		-- bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg1 = 0xffeee8d5, -- Spaces background / base2
	bg2 = 0xffeee8d5, -- Apple & Date background / base2

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
