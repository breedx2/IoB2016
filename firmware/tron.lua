

-- Id      : Tron
-- Created : Zach Archer

LED_PIN    = 1
TRON_TIME  = 120

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

	brt = math.max( 0, brt-25 )

	if math.abs( pos - bid ) < 0.5 then
		brt = 255
	end

	COLOR = string.char(brt, brt, brt):rep(72)
	ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TRON_TIME, 1, function() show() end )

print("One WS2812 connected to D1 will changes its color repeatedly")
print("Stop this by tmr.stop(SEQTIMERID)")
show()
