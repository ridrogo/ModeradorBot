local function expr(msg, blocks)
		local do_entry = blocks[1]
		local result = "expr "..do_entry
		local final_result = result:gsub('+', ' + '):gsub('*', ' \\* '):gsub('/', ' / '):gsub('-', ' - ')
		local action = io.popen(final_result)
		local read = action:read("*a")
		return read
end

local action = function(msg, blocks)
local do_expr = expr(msg, blocks)

api.sendReply(msg, '*Resultado* _'..do_expr..'_', true)

end 


return {
   information = "Plugin calc by @Jarriz to QuickBot",
   action = action,
   triggers = {
  '^/calc (.+)$',
  }
}