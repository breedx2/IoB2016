-- Id : Bonfire
-- Created : ZKA

LED_PIN=1
TIME=65
FQ=500

brt=1
dir=1
rnd=0
pxoff=0
i=0

byi=4
fr=FQ/5
dfr=1
lum=0

if file.open("config.lua","r") then
	f=file.readline()
	file.close()

	bid=tonumber(string.match(f,"tid={(.+)}"))-201
	byi=4-math.floor(bid/10)
end

function show()
	fr=fr+dfr
	dfr=dfr+0.01
	if fr>=(FQ*10) then
		fr=0
		dfr=1
	end

	h=(fr-(byi*FQ))

	t=h*(11/FQ)+3
	t=math.max(3,math.min(14,t))

	rnd = math.random(50)
	if brt >= t then
		dir=-1
	elseif brt <= 1 then
		dir=1
	elseif rnd <= 2 then
		dir=dir*-1
	end

	brt=math.floor(brt+dir)

	pxoff=18-brt

	l=h/FQ
	if math.random(12)<1 then
		lum=1
	else
		lum=math.max(0.05,math.min(1.0,l))*0.02 + lum*0.98
	end

	DARK = string.char(0,0,0):rep(pxoff)
	HEAD = string.char(0,255*lum,0):rep(3)
	BODY = string.char(40*lum,255*lum,0):rep(15-pxoff)

	COLOR = (DARK..HEAD..BODY..BODY..HEAD..DARK):rep(2)
	ws2812.write(LED_PIN, COLOR)
end

tmr.alarm(SEQTIMERID,TIME,1,function() show() end)
show()
