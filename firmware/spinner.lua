-- Id      : Spinner
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 120

i = 0

function show()
	i = (i + 1) % 4

	RED = string.char(0,255,0):rep(18)
	GREEN = string.char(255,0,0):rep(18)
	BLUE = string.char(0,0,255):rep(18)
	BLACK = string.char(0,0,0):rep(18)

	COLOR = ""
	if i == 0 then
		COLOR = RED..BLACK..BLUE..BLACK
		COLOR = RED..GREEN..BLUE..BLACK
	elseif i == 1 then
		COLOR = BLACK..BLUE..BLACK..RED
		COLOR = GREEN..BLUE..BLACK..RED
	elseif i == 2 then
		COLOR = BLUE..BLACK..RED..BLACK
		COLOR = BLUE..BLACK..RED..GREEN
	elseif i == 3 then
		COLOR = BLACK..RED..BLACK..BLUE
		COLOR = BLACK..RED..GREEN..BLUE
	end

	ws2812.write(LED_PIN, COLOR)
end


tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
