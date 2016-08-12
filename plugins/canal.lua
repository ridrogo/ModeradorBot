local function do_keyboard_public()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = '👥 Agregame a tu grupo', url = 'https://telegram.me/'..bot.username..'?startgroup=new'},
    		{text = '👥 Agrega al bot de soporte a tu grupo', url = 'https://telegram.me/GroupButlerEspSupp_bot?startgroup=new'},
    	},
	    {
    		{text = '📢 Canal de ayuda', url = 'https://telegram.me/'..config.channel:gsub('@', '')},
	        {text = '📕 Todos los Comandos', callback_data = '!user'},
        },
    	{
    		{text = '✅ Canal', url = 'https://telegram.me/'..config.channel:gsub('@', '')},
    		{text = '✅ GitHub', url = 'https://github.com/ridrogo/ModeradorBot'},
    	},	
    	{	
    		{text = '✅ Wamods.com', url = 'https://telegram.me/Wamods'},
    		{text = '✅ WereWolf Español Oficial', url = 'https://telegram.me/werewolfespoficial'},
    	},	
        {
            {text = '✅ Death Note Serie', url = 'https://telegram.me/DeathNoteSerie'},
        	{text = '✅ Evalúame!', url = 'https://telegram.me/storebot?start=GroupButlerEsp_bot'},
		},
		{
		    {text = '🔙', callback_data = '!user'}
        }
	}
	return keyboard
end

local function do_keyboard_startme()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = 'Debes iniciarme primero', url = 'https://telegram.me/'..bot.username}
	    }
    }
    return keyboard
end
local action = function(msg, blocks, ln)
         if blocks[1] == 'links' then
--            api.sendKeyboard(msg.chat.id, do_keyboard_startme(), true) 
            api.sendMessage(msg.chat.id, 'Se han enviado los links por chat privado, para verlos debes iniciar el bot aqui [Iniciame](https://telegram.me/'..bot.username..')', true)
            local message = make_text(msg.from.first_name:mEscape()) 
            api.sendMessage(msg.from.id, 'Aquí tienes algunos links de interés, quieres aparecer aqui?, contacta con @Webrom o @Webrom2', true)
            local keyboard = do_keyboard_public()
            api.sendKeyboard(msg.from.id, message, keyboard, true)
        end
        return
    end

return {
	action = action,
	triggers = {
		'^/(links)$'
	}
}