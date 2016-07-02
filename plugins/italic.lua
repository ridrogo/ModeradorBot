local triggers = {
	'^/(italic) (.*)$',
	'^/(bold) (.*)$'
	}

local action = function(msg, matches)
	if matches[1] == 'italic' then
		api.sendMessage(msg.chat.id, '_' ..matches[2].. '_', true)
		end

    if matches[1] == 'bold' then
    api.sendMessage(msg.chat.id, '*' ..matches[2].. '*', true)
	end
end


 return {
 	triggers = triggers,
 	action = action
 	
 	}
 	