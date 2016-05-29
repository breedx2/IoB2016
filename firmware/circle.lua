-- Id      : Circle radiator
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 30

bucketid = 0

bx = 0
by = 0
phase = 0
wave = 0
brt = 0

if file.open("config.lua", "r") then
	settings = file.readline()
	file.close()

	ssid, pwd, bucketid = string.match(settings, "ssid={(.+)}:pwd={(.+)}:bucketid={(.+)}")
	bx = (((bucketid-200) % 10) - 5) * 0.667
	by = math.floor( (bucketid-200) / 10 ) - 2
end

function tri( v )
	out = math.abs(v) % 2.0
	if( out < 0.3 ) then
		out = out * (1.0 / 0.3)
	else
		out = (2.0 - out) * (1.0 / 1.7)
	end
	return out
end

function show()
	phase = phase + 0.013

	wave = tri( math.sqrt( bx*bx + by*by ) / 3.5 - phase )

	-- Lazy gamma correction
	wave = wave * wave

	-- Low power draw plz
	brt = math.floor(wave*66)

  COLOR = string.char(brt,brt,0):rep(72)
  ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
