local action = function(msg, blocks, ln)

if not (msg.chat.type == 'private') and is_mod(msg) then 

 if blocks[1] == 'bots' then
		if not blocks[2]:match('^(enable)$') and not blocks[2]:match('^(disable)$') then
			api.sendReply(msg, '*ERROR*\nDebe usarse de esta manera:\n`/bots enable|disable`', true)
			return
		end
		local status = blocks[2]
		local current = db:hget('chat:'..msg.chat.id..':settings', 'bots')
		if current == status then
			grep = status:gsub('^enable$', 'permitidos'):gsub('^disable$', 'prohibidos')
			api.sendMessage(msg.chat.id, 'Los bots ya estaban *'..grep..'*', true)		
		else
			db:hset('chat:'..msg.chat.id..':settings', 'bots', status)
			grep = status:gsub('^enable$', 'permitidos'):gsub('^disable$', 'prohibidos')
			api.sendMessage(msg.chat.id, 'Ahora los bots estarán *'..grep..'*', true)
		end
	end
  end
end

return {
	action = action,
	triggers = {
	'^/(bots) (%a+)$',
	}
}