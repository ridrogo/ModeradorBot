local triggers = {
		'^/(talk) (-?%d+) (.*)$',
		'^/(talk) (.*)$'
		}


local action = function(msg, blocks, ln)

	if blocks[1] == 'talk' then
		if not blocks[2] then
			api.sendMessage(msg.from.id, 'Specify an id or reply with the message')
			return
		end
		local id, text
		if blocks[2]:match('(-?%d+)') then
			if not blocks[3] then
				api.sendMessage(msg.from.id, 'Text is missing')
				return
			end
			id = blocks[2]
			text = blocks[3]
		else
			if not msg.reply then
				api.sendMessage(msg.from.id, 'Reply to a user to send him a message')
				return
			end
			id = msg.reply.from.id
			text = blocks[2]
		end
		local res = api.sendMessage(id, text)
		if res then
			api.sendMessage(msg.chat.id, 'Successful delivery')
		end
end

end
 return {
   action = action,
   triggers = triggers
   }