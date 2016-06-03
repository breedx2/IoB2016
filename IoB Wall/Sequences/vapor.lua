-- Id      : Vapor
-- Created : Zach Archer

LED_PIN    = 1
FIRE_TIME       = 65

brt = 1
dir = 1
rnd = 0
pxoff = 0
i = 0

function show()
  rnd = math.random(50)

  if brt >= 15 then
    dir = -1
  elseif brt <= 0 then
    dir = 1
  elseif rnd <= 1 then
    dir = dir * -1
  end

  brt = math.floor( brt + dir )

	pxoff = 15 - brt

	HI = string.char(0,0,0):rep(pxoff)
	LIGHT = string.char(255,255,255):rep(3)
	LO = string.char(0,0,0):rep(15-pxoff)

	COLOR = (HI..LIGHT..LO..LO..LIGHT..HI):rep(2)

	ws2812.write(LED_PIN, COLOR)
end


tmr.alarm(SEQTIMERID, FIRE_TIME, 1, function() show() end )

show()
