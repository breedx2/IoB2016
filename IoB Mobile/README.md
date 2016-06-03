# IoB Mobile

These Buckets all have their own Access Points!

Bucket IDs: 1-20, This should be written on each bucket
Access Point Names: Bucket1 - Bucket 20
Access Point Password: toorcamp
Subnets: 10.1.10.1 through 10.20.10.1, based on Bucket ID (10.BucketID.10.1)
Netmask: 255.255.0.0
HTTP Server for GET Requests: 10.Bucket ID.10.1


URI Examples:

Sequence for Bucket ID #1:
http://10.1.10.1/?sequence=fire

RGB for Bucket ID #5:
http://10.5.10.1/?r=0&g=0&b=42

Spreading RGB Sequence for Bucket IDs 1-3 (Experimental)
http://10.1.10.1/?sequence=3spread&r=0&g=42&b=0