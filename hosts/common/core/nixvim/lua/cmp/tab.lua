-- Mapping for tab key for cmp
cmp.mapping(function(fallback)
	local luasnip = require("luasnip")
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expandable() then
		luasnip.expand()
	elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	else
		fallback()
	end
end, { "i", "s" })
