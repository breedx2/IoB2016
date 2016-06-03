

-- Id      : Ocean2
-- Created : Zach Archer

LED_PIN    = 1
OCEAN_TWO_TIME       = 65  -- 0.500 second,  2 Hz

brt = 1
dir = 1
rnd = 0
pxoff = 0
i = 0

function show()
  rnd = math.random(50)

  if brt >= 14 then
    dir = -1
  elseif brt <= 1 then
    dir = 1
  elseif rnd <= 2 then
    dir = dir * -1
  end

  brt = math.floor( brt + dir )

	pxoff = 18 - brt

	DARK = string.char(0,0,0):rep(pxoff)
	DARKTWO = string.char(40,255,0):rep(15-pxoff)
	LIGHT = string.char(0,255,0):rep(3)

	COLOR = DARK .. LIGHT .. DARKTWO .. DARKTWO .. LIGHT .. DARK .. DARK .. LIGHT .. DARKTWO .. DARKTWO .. LIGHT .. DARK

	ws2812.write(LED_PIN, COLOR)
end


tmr.alarm(SEQTIMERID, OCEAN_TWO_TIME, 1, function() show() end )

print("One WS2812 connected to D1 will changes its color repeatedly")
print("Stop this by tmr.stop(SEQTIMERID)")
show()
