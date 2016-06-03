

-- Id      : Ocean
-- Created : Zach Archer

LED_PIN    = 1
OCEAN_TIME       = 30  -- 0.500 second,  2 Hz

brt = 0
dir = 1
rnd = 0

function show()
	rnd = math.random(50)

	if brt >= 150 then
		dir = -1
	elseif brt <= 5 then
		dir = 1
	elseif rnd <= 2 then
		dir = dir * -1
	end

	brt = math.floor( brt + dir )

	COLOR = string.char(brt, 0, brt):rep(72)
	ws2812.write(LED_PIN, COLOR)
end


tmr.alarm(SEQTIMERID, OCEAN_TIME, 1, function() show() end )

show()
