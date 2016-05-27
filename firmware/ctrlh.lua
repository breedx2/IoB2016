-- Id      : CtrlH
-- Created : Zach Archer

LED_PIN    = 1
TIME       = 30

bid = 0

glyph = 0
ph = 0
i = 0
br = 255

rs = {1,1,0,0,0,1,1}
gs = {0,1,1,1,0,0,0}
bs = {0,0,0,1,1,1,0}

if file.open("config.lua", "r") then
	settings = file.readline()
	file.close()

	ssid, pwd, bid = string.match(settings, "ssid={(.+)}:pwd={(.+)}:bucketid={(.+)}")

	img = { 0,0,1,1,0,2,0,0,2,0, 0,1,0,1,0,2,0,0,2,0, 0,0,0,1,0,2,2,2,2,0, 0,0,0,0,0,2,0,0,2,0, 0,0,0,0,0,2,0,0,2,0 }
	glyph = img[ bid - 200 ]

	if glyph == 0 then
		br = 27
	end
end

function lerp(a,b,p)
	return a + (b-a)*p
end

function show()
	ph = ph + 0.02 * (glyph+0.21)
	if ph >= 1.0 then
		ph = ph - 1.0
		i = (i + 1) % 6
	end

	r = lerp( rs[i+1], rs[i+2], ph ) * br
	g = lerp( gs[i+1], gs[i+2], ph ) * br
	b = lerp( bs[i+1], bs[i+2], ph ) * br

	COLOR = string.char(g,r,b):rep(72)

  ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID, TIME, 1, function() show() end )

show()
