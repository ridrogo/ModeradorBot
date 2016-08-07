local triggers = {
--	'^https://telegram.me/(.*)$',
--    '^https://telegram.me/joinchat/(.*)$',
--	'^http://telegram.me/(.*)$',
--    '^http://telegram.me/joinchat/(.*)$',
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]",
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Oo][Rr][Gg]%",
            "[Cc][Aa][Nn][Aa][Ll] @(.*)",
            "[Cc][Hh][Aa][Nn][Nn][Ee][Ll] @(.*)"
}

local action = function(msg, matches, blocks, ln)
 		
 			local is_normal_group = false
	   		if msg.chat.type == 'group' then is_normal_group = true end
 		
    if db:hget('bot:general', 'antispam') == 'on' then
	local iduser = msg.from.id
    local name = msg.from.first_name
    if msg.from.username then name = name..' (@'..msg.from.username..')' end
    	        api.sendMessage(msg.chat.id, '\n\n_ID Del Usuario_: ' ..iduser.. '\n_Nombre_: ' ..name.. ' *Ha sido expulsado por publicar links de invitaciones de otros grupos y/o hacer tag de algún canal.*\n*No olviden leer las reglas, para asi evitar recibir un ban definitivo.* ', true)
    	        api.kickUser(msg.chat.id, msg.from.id)
    	    return msg, true
	    end
end

 return {
	action = action,
	triggers = triggers
}
