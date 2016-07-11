local action = function(msg, blocks, ln)
--api.kickUser(chat_id, user_id, ln)
--api.sendMessage(msg.chat.id, '_Prohibido enviar enlaces al grupo sin autorización de los Admins..._\n_La proxima seras advertido a ' ..matches[1]..'_...', true)
iduser = msg.from.id
name = msg.from.first_name
user = msg.from.username
api.kickUser(msg.chat.id, msg.from.id, ln)
api.sendMessage(msg.chat.id, '\n\n_ID Del Usuario_: ' ..iduser.. '\n_Nombre_: ' ..name.. '\n_Usuario_: @' ..user.. '  *Ha sido expulsado por publicar links de invitaciones de otros grupos y/o hacer tag de algún canal.* \n_Si eres Admin ignora el mensaje._ *No olviden leer las reglas, para asi evitar recibir un ban definitivo.* ', true)
end
return {
   action = action,
   triggers = {
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Mm][Ee]",
            "[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm]%.[Oo][Rr][Gg]",
            "[Cc][Aa][Nn][Aa][Ll] @(.*)",
            "[Cc][Hh][Aa][Nn][Nn][Ee][Ll] @(.*)",
         }
     }
