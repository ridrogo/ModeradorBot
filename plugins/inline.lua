local triggers = {
	'^/(inline)$'
}

local action = function(msg)
	local input = URL.escape(msg.text:input())

	if input == 'emoji' then -- BETA test OFF NotSOON :/
		local text = "["..inline_block('( ͡° ͜ʖ ͡°)', '( ͡° ͜ʖ ͡°)')..', '
		text = text .. inline_block('ʘ‿ʘ', 'ʘ‿ʘ')..', '
		text = text .. inline_block('(╯°□°）╯︵ ┻━┻', '(╯°□°）╯︵ ┻━┻')..', '
		text = text .. inline_block('(ツ)_/¯', '(ツ)_/¯')..']'
		sendInline(msg.id, URL.escape(text))
	else
		local text = "["..inline_block('Bold', '*'..input..'*')..', '
		text = text .. inline_block('Italic', '_'..input..'_')..', '
		text = text .. inline_block('Code', '```'..input..'```')..']'
		sendInline(msg.id, text)
	end
end

return {
	action = action,
	triggers = triggers
}