ws2812.write(pin, string.char( tonumber(p.g), tonumber(p.r), tonumber(p.b) ):rep(72))
if p.ttl then
  ttl = tonumber(p.ttl)
else
  ttl = 5
end

if ttl == 0 then
  next_ttl = 0
else
  next_ttl = ttl - 1
end

if next_ttl == 0 then
  return
end

if bucketid == "16" then
fwdid = 20
elseif bucketid == "11" then
fwdid = 15
elseif bucketid == "6" then
fwdid = 10
elseif bucketid == "1" then
fwdid = 5
else
fwdid = bucketid - 1
end
print("fwdid="..fwdid)
wifi.setmode(wifi.STATIONAP)
wifi.sta.config("Bucket"..fwdid,pwd)
wifi.sta.connect()
ip = wifi.sta.getip()



--192.168.18.110

spread_timeout_counter = 0

tmr.alarm(5,1000, 1, function() 
  if wifi.sta.getip()==nil then
    spread_timeout_counter = spread_timeout_counter + 1
    if spread_timeout_counter > 20 then
      print('giving up')
      ws2812.write(pin, string.char( tonumber(p.g), tonumber(p.r), tonumber(p.b) ):rep(72))
      tmr.delay(500000)
      ws2812.write(pin, string.char( "0", "0", "0" ):rep(72))
      tmr.delay(500000)
      ws2812.write(pin, string.char( tonumber(p.g), tonumber(p.r), tonumber(p.b) ):rep(72))
      tmr.delay(500000)
      ws2812.write(pin, string.char( "0", "0", "0" ):rep(72))
      tmr.delay(500000)
      ws2812.write(pin, string.char( tonumber(p.g), tonumber(p.r), tonumber(p.b) ):rep(72))

      tmr.stop(5)
      node.restart()
    else
      print("Waiting for IP address!")
    end
  else
     print("New IP address is "..wifi.sta.getip())
    tmr.stop(5)

    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) print(payload) end )
    conn:on("disconnection", function()
        wifi.sta.disconnect()
        tmr.stop(SEQTIMERID)
        tmr.delay(10000000)
        node.restart()
   end )
    conn:on("connection", function(c)
      print('spreading r='..p.r..', g='..p.g..', b='..p.b..' with ttl '..next_ttl)  
      conn:send("GET /?sequence=spreadrgb&r="..p.r.."&g="..p.g.."&b="..p.b.."&ttl="..next_ttl.." HTTP/1.1\r\nHost: www.baidu.com\r\n"
                .."Connection: keep-alive\r\nAccept: */*\r\n\r\n") 
    end)
    conn:connect(80,"10."..fwdid..".10.1")
  end
end)
