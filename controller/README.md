# Controller server

Helps to coordinate sending of mass-bucket commands.

# rgb

Send the same rgb values to every bucket.

```
curl http://server:9090/rgb?r=255&g=0&b=0
```

# rainbow

Not to be confused with the rainbow "sequence" firmware.  Puts a random r,g,b value on every bucket.

```
curl http://server:9090/rainbow
```

# flipper

Sets all the buckets to the same random color, over and over.

## Params
* times - the nubmer of times to do this
* rate - the number of ms between pushes.  Anything under about 250ms is hard to maintain as stable.  

`rate * times` should be approximately how long the sequence runs (in ms).

```
curl http://server:9090/flipper?rate=350&times=100
```
