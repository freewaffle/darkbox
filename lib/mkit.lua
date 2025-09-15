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

local ID = {
	SOUND = {
		SP = "game:/sound#sp",
		SP_MAX = 7
	},

	HUD = msg.url("game:/ui#hud")
}

local MSG = {
	UPDATE_SPEECH = hash("update_speech"),
	SOUND_DONE = hash("sound_done")
}

local speechpart_count = 0
local speechpart_prev = 0

local function speechpart_handle(self, message_id, message, handler)
	speechpart_count = speechpart_count - 1
	if speechpart_count > 0 and message_id == MSG.SOUND_DONE then
		local magic = (math.random(-1, 2) / 20)
		local r
		while true do
			r = math.random(1, ID.SOUND.SP_MAX)
			if r ~= speechpart_prev then
				speechpart_prev = r
				break
			end
		end
		sound.play(ID.SOUND.SP .. r, {
			--delay = 0.1 * (magic + 0.05),
			speed = 1 + magic
		}, speechpart_handle)
	else
		speechpart_count = 0
	end
end

local function play_speech(count)
	if count then
		speechpart_count = speechpart_count + count
	end
	math.randomseed(os.time())
	speechpart_prev = math.random(1, ID.SOUND.SP_MAX)
	sound.play(ID.SOUND.SP .. speechpart_prev, nil, speechpart_handle)
end

local speech_stack = {}

local had_speech_before = false

local function hide_speech()
	msg.post(ID.HUD, MSG.UPDATE_SPEECH, {
		show = false
	})
	sound.stop(ID.SOUND.SPEECH)
	had_speech_before = false
end

local function speech_pop_handle()
	local speech = table.remove(speech_stack, 1)
	if speech then
		msg.post(ID.HUD, MSG.UPDATE_SPEECH, {
			show = true,
			text = speech
		})
		if not had_speech_before then
			-- sound.play(ID.SOUND.SPEECH)
			play_speech(math.ceil(#speech * 0.1))
			had_speech_before = true
		end
	else
		hide_speech()
	end
end

local speech_pop_timer = nil

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local M = {}

function M.restart()
	if speech_pop_timer then timer.cancel(speech_pop_timer) end
	speech_pop_timer = timer.delay(5, true, speech_pop_handle)
end

function M.make(fn_init, fn_update)
	if not fn_init then
		error("missing an init function", 2)
	else
		return {
			env = {},
			fn_init = fn_init,
			fn_update = fn_update
		}
	end
end

function M.add_speech(speech)
	local had_not_speech = #speech_stack <= 0
	
	if type(speech) == "table" then
		for i,s in ipairs(speech) do
			if type(s) == "string" then
				speech_stack[#speech_stack+1] = s
			else
				error(string.format("invalid type of field %d: expected string, found %s", i, type(s)), 2)
			end
		end
	elseif type(speech) == "string" then
		speech_stack[#speech_stack+1] = speech
	else
		error(string.format("invalid argument type: expected table or string, found %s", type(speech)), 2)
	end

	if had_not_speech then
		speech_pop_handle()
		M.restart()
	end
end

function M.remove_speech(n)
	if n then
		if type(n) == "number" then
			speech_stack[n] = nil
		else
			error(string.format("invalid `n` argument type: expected number, found %s", type(n)), 2)
		end
	else
		speech_stack = {}
	end
end

function M.interrupt_speech(speech)
	local ts = type(speech)
	if ts == "table" or ts == "string" then
		speechpart_count = 0
		sound.stop(ID.SOUND.SPEECHPART)
		
		M.remove_speech()
		M.add_speech(speech)
	else
		error(string.format("invalid argument type: expected table or string, found %s", ts), 2)
	end
end

return M