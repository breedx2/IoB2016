# IoB2016
[DorkbotPDX](http://dorkbotpdx.org) and [Ctrl-H](http://pdxhackerspace.org/) [Toorcamp](http://toorcamp.org) 2016 IoB (Internet of Buckets)

<img src="https://scontent.fsnc1-1.fna.fbcdn.net/t31.0-8/13217280_1076334432404913_794862734443089774_o.jpg" width="250">

## Wall

A wall of 50 (10x5) multicolor network-addressable buckets.

### Hardware

nodemcu esp8266

### Network

192.168.16.201 - 250

### Examples

sending files "sequences" to nodemcus
```
curl --data-binary @rainbow.lua http://192.168.16.201/upload/rainbow.lua
```

activate sequence
```
curl http://192.168.16.201?sequence=rainbow
```

change rgb values
```
curl "http://192.168.16.201?r=0&g=0&b=120"
```

## Indies

20 individual battery-powered multicolor buckets.
