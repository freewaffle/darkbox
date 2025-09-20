--[[
Этот файл — часть Darkbox.

Darkbox — свободная программа: вы можете перераспространять ее и/или
изменять ее на условиях Стандартной общественной лицензии GNU в том
виде, в каком она была опубликована Фондом свободного программного
обеспечения; либо версии 3 лицензии, либо (по вашему выбору) любой
более поздней версии.

Darkbox распространяется в надежде, что она будет полезной, но БЕЗО
ВСЯКИХ ГАРАНТИЙ; даже без неявной гарантии ТОВАРНОГО ВИДА или
ПРИГОДНОСТИ ДЛЯ ОПРЕДЕЛЕННЫХ ЦЕЛЕЙ. Подробнее см. в Стандартной
общественной лицензии GNU.

Вы должны были получить копию Стандартной общественной лицензии GNU
вместе с этой программой. Если это не так, см.
<https://www.gnu.org/licenses/>.
]]

----------------------------------------------------------------------

local function init()
	print("locale service started")
	
	local txt
	do
		local file, err = io.open("data/locale.json")
		if file ~= nil then
			txt = file:read("*a")
			file:close()
		else
			error("unable to open '/data/locale.json' file: " .. err, 0)
		end
	end
	collectgarbage()

	return assert(json.decode(txt), "'/data/locale.json' decode failed")
end

local locale = init()
local lang = "ru"

----------------------------------------------------------------------

local M = {}

function M.shutdown()
	print("locale service shutdown")
	locale = nil
	collectgarbage()
end

function M.init()
	if type(locale) ~= "table" then
		locale = init()
	end
end

function M.get_page(page_name)
	if locale ~= nil then
		local page = assert(locale[page_name], "unable to find locale page: " .. page_name)
		return (assert(page[lang], string.format("unable to find language '%s' in page '%s'", lang, page_name)))
	else
		error("start the service!", 2)
	end
end

return M