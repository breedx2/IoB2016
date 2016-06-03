

-- Id      : Tron
-- Created : Zach Archer

LED_PIN    = 1
TIME  = 120

bid = 200
pos = 225
dd = 0
brt = 50

dirs = {1,1,1,1,10, 10,10,-1,-1,-1, -1,-1,-1,-10,-10, -1,-1,-1,10,10, 10,1,1,1,1, 1,-10,-10,1,1, 10,10,10,-1,-1, -1,-1,-10,-10,-10 }

if file.open("config.lua", "r") then
	settings = file.readline()
	file.close()

	ssid, pwd, bid = string.match(settings, "ssid={(.+)}:pwd={(.+)}:bucketid={(.+)}")
end

function show()
	dd = (dd + 1) % 40

	pos = pos + dirs[dd+1]

	if pos < 201 then
		pos = pos + 50
	elseif pos > 250 then
		pos = pos - 50
	end

	brt = math.max( 0, brt-8 )

	if math.abs( pos - bid ) < 0.5 then
		brt = 128
	end

	COLOR = string.char(brt, 0, 0):rep(72)
	ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
