local action = function(msg, matches, ln)
	api.sendMessage(msg.chat.id, make_text '' ..matches[1].. '', true)
	mystat('[Mm][Aa][Ee][Ii][Oo][Uu]')
end

return {
	action = action,
	triggers = {
		'^! (.*)$'
	}
}
