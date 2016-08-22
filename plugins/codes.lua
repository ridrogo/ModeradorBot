local action = function(msg, blocks)

if db:hget('chat:'..msg.chat.id..':settings', 'codes') == 'enable' then
local d = blocks[1]
api.sendMessage(msg.chat.id, d, true) 

end
end

return {
       action = action,
       triggers = {
                '- (.*)$',
                   }
                  }