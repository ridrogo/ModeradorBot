local action = function(msg, blocks, ln)
--api.kickUser(chat_id, user_id, ln)
--api.sendMessage(msg.chat.id, '_Prohibido enviar enlaces al grupo sin autorización de los Admins..._\n_La proxima seras advertido a ' ..matches[1]..'_...', true)
user = msg.from.username
api.deleteMessages(msg.chat.id, msg.from.id, ln)
api.kickUser(msg.chat.id, msg.from.id, ln)
api.sendMessage(msg.chat.id, 'El usuario @' ..user.. '  ha sido expulsado por hacer spam. *No olviden leer las reglas, para asi evitar recibir un ban definitivo* ', true)
end
return {
   action = action,
   triggers = {
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]",
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Oo][Rr][Gg]",
         }
     }
