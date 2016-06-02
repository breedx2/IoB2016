-- Id      : Off
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 65

function show()
	COLOR = string.char(0,0,0):rep(72)
	ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
