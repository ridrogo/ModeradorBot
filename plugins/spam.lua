local action = function(msg, blocks, ln)

if not (msg.chat.type == 'private') and is_mod(msg) then 

 if blocks[1] == 'spam' then
		if not blocks[2]:match('^(enable)$') and not blocks[2]:match('^(disable)$') then
			api.sendReply(msg, '*ERROR*\nDebe usarse de esta manera:\n`/spam enable|disable`', true)
			return
		end
		local status = blocks[2]
		local current = db:hget('chat:'..msg.chat.id..':settings', 'spam')
		if current == status then
			grep = status:gsub('^enable$', 'permitido'):gsub('^disable$', 'prohibido')
			api.sendMessage(msg.chat.id, 'El spam ya estaba *'..grep..'*', true)		
		else
			db:hset('chat:'..msg.chat.id..':settings', 'spam', status)
			grep = status:gsub('^enable$', 'permitido'):gsub('^disable$', 'prohibido')
			api.sendMessage(msg.chat.id, 'Ahora el spam estará *'..grep..'*', true)
		end
	end
  end
end

return {
	action = action,
	triggers = {
	'^/(spam) (%a+)$',
	}
}
