-- Mapping for arrow key up for cmp
cmp.mapping(function(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	else
		fallback()
	end
end, { "i", "s" })
