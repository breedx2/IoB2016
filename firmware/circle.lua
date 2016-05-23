-- Id      : Circle radiator
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 30  -- 0.500 second,  2 Hz

bucketid = 0

radius = 0
tri = 0
brt = 0

if file.open("config.lua", "r") then
	settings = file.readline()
	file.close()

	ssid, pwd, bucketid = string.match(settings, "ssid={(.+)}:pwd={(.+)}:bucketid={(.+)}")
	bx = ((bucketid-200) % 10) - 5
	by = math.floor( (bucketid-200) / 10 ) - 5

	radius = math.sqrt( bx*bx + by*by )
end

function show()
	radius = radius - 0.013
	while radius < 0 do
		radius = radius + 2.0
	end
	while radius > 2.0 do
		radius = radius - 2.0
	end

	tri = radius
	if tri > 1.0 then
		tri = 2.0 - tri
	end

	-- Lazy gamma correction
	tri = tri * tri

	brt = math.floor(tri*255)

  COLOR = string.char(brt,brt,0):rep(72)
  ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
