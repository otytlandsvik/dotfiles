-- Mapping for arrow key down for cmp
cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	else
		fallback()
	end
end, { "i", "s" })
