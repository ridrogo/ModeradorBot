local action = function(msg, blocks)
 num = math.random(0,8);
 if num == 0 then
	api.sendReply(msg,  '_Sí_.', true)
 elseif num == 1 then
 	api.sendReply(msg,  '_No_.', true)
 elseif num == 2 then
	api.sendReply(msg,  '_Puede ser que sí_.', true)
 elseif num == 3 then
	api.sendReply(msg,  '_Puede ser que no_.', true)
 elseif num == 4 then
	api.sendReply(msg,  '_Eso es muy tonto_.', true)
 elseif num == 5 then
	api.sendReply(msg,  '_Pregunta otra cosa_.', true)
 elseif num == 6 then
	api.sendReply(msg,  '_Yo no lo creo_.', true)
 elseif num == 7 then
	api.sendReply(msg,  '_Sin palabras_.', true)
 elseif num == 8 then
	api.sendReply(msg,  '_Imposible_.', true)
    end
end

 return {
 	action = action,
 	triggers = {
 		'/sera (.*)'
 		}
 	}