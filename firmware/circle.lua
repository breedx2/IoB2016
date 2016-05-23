-- Id      : Circle radiator
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 30

bucketid = 0

bx = 0
by = 0
phase = 0
px = 0
py = 0
wave = 0
brt = 0

if file.open("config.lua", "r") then
	settings = file.readline()
	file.close()

	ssid, pwd, bucketid = string.match(settings, "ssid={(.+)}:pwd={(.+)}:bucketid={(.+)}")
	bx = ((bucketid-200) % 10) - 5
	by = math.floor( (bucketid-200) / 10 ) - 2
end

function tri( v )
	out = math.abs(v) % 2.0
	if out > 1.0 then
		out = 2.0 - out
	end
	return out
end

function show()
	phase = phase - 0.013
	px = (tri(phase/2+0.5) * 4) + bx
	py = (tri(phase+0.5) * 2) + by

	wave = tri( math.sqrt( px*px + py*py ) / 2 )

	-- Lazy gamma correction
	wave = wave * wave

	brt = math.floor(wave*255)

  COLOR = string.char(brt,brt,0):rep(72)
  ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
