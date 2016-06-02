-- Id      : Spinner
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 120

i = 0

function show()
	i = (i + 18*3) % (72 * 3)

	RED = string.char(0,255,0):rep(18)
	GREEN = string.char(255,0,0):rep(18)
	BLUE = string.char(0,0,255):rep(18)
	BLACK = string.char(0,0,0):rep(18)

	LONG = (RED..GREEN..BLUE..BLACK..RED..GREEN..BLUE..BLACK)

	COLOR = string.sub(LONG, i+1, i+(72*3)+1)

	ws2812.write(LED_PIN, COLOR)
end


tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
