local action = function(msg, matches, ln)
	api.sendMessage(msg.chat.id, make_text '' ..matches[1].. '', true)
end

return {
	action = action,
	triggers = {
		'^/[Ss]ay (.*)$',
		'^/di (.*)$'
	}
}
