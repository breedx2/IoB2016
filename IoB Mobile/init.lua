if file.open("config.lua", "r") then
  settings = file.readline()
  file.close()

  -- ssid={CTRLH}:pwd={321ETC}:bucketid={1}
  pwd, bucketid = string.match(settings, "pwd={(.+)}:bucketid={(.+)}")


  -- ap stuff

  c={} c.ssid="Bucket"..bucketid c.pwd=pwd c.chan="1"
  wifi.setmode(wifi.SOFTAP)
  wifi.ap.config(c)

  
  c = {}
  c.ip = "10."..bucketid..".10.1"
  c.netmask = "255.255.0.0"
  c.gateway = "10."..bucketid..".10.1"

  wifi.ap.setip(c)
  print(wifi.ap.getip())


--function x2c(x) return string.char(tonumber(x, 16)) end
--function unencode(s) return s:gsub("%%(%x%x)", x2c) end

--ws2812.init()

pin = 1

clear = {}
clear.r = 0
clear.g = 0
clear.b = 0
--ws2812.write(pin, string.char( clear.g, clear.r, clear.b ):rep(72)

current_sequence = nil

SEQTIMERID = 0

function start()
  srv=net.createServer(net.TCP)
  srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)

      -- print("here's the payload")
      -- print(payload)
      -- print("there's the payload")

      -- curl --data-binary @rainbow.lua http://192.168.16.201/upload/rainbow.lua

      if string.match(payload, "POST /upload") then
        local filename = string.match(payload, "POST /upload/(.+) HTTP")
        local bodyStart = payload:find("\r\n\r\n", 1, true)
        local body = payload:sub(bodyStart, #payload)

        print('writing file '..filename)

        file.open(filename, 'w')
        file.write(body)
        file.close()
      else

        q = string.match(payload, "GET (.+) HTTP")
      
        if q ~= "/favicon.ico" then
          if q ~= "/" then
            p = {}
            for k, v in string.gmatch(q, "([^?=&]+)=(([^&]*))" ) do p[k] = v end

            if p.sequence then
              current_sequence = p.sequence

              local filename = p.sequence..'.lua'
              tmr.stop(SEQTIMERID)
              loadfile(filename)()
            else
              -- "r=120&g=50&b=27"
              print('setting RGB('..p.r..','..p.g..','..p.b..')')

              tmr.stop(SEQTIMERID)
          
              -- Set the lights!
              ws2812.write(pin, string.char( tonumber(p.g), tonumber(p.r), tonumber(p.b) ):rep(72))
            end
          end
        end
      end

      conn:send("ok")
    end)
    conn:on("sent",function(conn) conn:close() end)
  end)
end


  -- Prevent a lock in the event of bug
  tmr.alarm(0, 5000, 0, function()
    start()
  end)
end
