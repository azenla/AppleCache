# Cache Server

The cache server is an HTTP server that is to sit on your local network.

It responds to the Apple Cache API, which is actually fairly simple.

When testing a cache server, the client seems to fetch / with a few specific headers.
As you will see later, Apple makes a large use of the headers. Almost too much, but I can see why they would, they want to make sure they don't alter the response content.

```http
GET / HTTP/1.1
Host: 10.0.0.60:54459
Max-Forwards: 0
X-Apple-Locator-Tag: #773c067b
Accept: */*
User-Agent: AssetCacheLocatorService/106.1 CFNetwork/1111 Darwin/19.0.0 (x86_64)
Accept-Language: en-us
Accept-Encoding: gzip, deflate
Connection: keep-alive

HTTP/1.1 200 OK
Date: Sat, 12 Oct 2019 07:53:44 GMT
Accept-Ranges: bytes
Content-Length: 0
```

A sample download flow is (taken from an iPhone downloading Skate City on Apple Arcade):

```http
GET /itunes-assets/Purple113/v4/8e/ce/1d/8ece1d03-212c-0cd1-c1ec-00e5d2f38152/pre-thinned16169977081049726707.thinned.signed.dpkg.ipa?accessKey=LONG_ACCESS_TOKEN_HERE&source=iosapps.itunes.apple.com HTTP/1.1
Host: 10.0.0.60:54459
Apple-Download-Type: redownload
Accept: */*
User-Agent: appstored/1 CFNetwork/1115 Darwin/19.0.0
Accept-Language: en-us
Accept-Encoding: gzip, deflate
Connection: keep-alive

HTTP/1.1 200 OK
Age: 618151
X-Apple-MS-Content-Length: 285978974
Access-control-allow-methods: HEAD, GET, PUT
Server: ATS/8.0.5
Cache-Control: private
Strict-Transport-Security: max-age=31536000; includeSubDomains;
X-Apple-Cached-Ranges: D885102C-110C-49BD-8672-7EF84A49C9AA bytes=0-154236588
X-iCloud-Content-Length: 285978974
Accept-Ranges: bytes
Access-Control-Allow-Origin: *
X-Responding-Server: massilia_protocol_035:735003803:ms11p01if-qufw20163201.ms.if.apple.com:8082:19T4:nocommit
Access-control-allow-headers: range
Content-Length: 285978974
Via: http/1.1 ussjc2-vp-vst-008.ts.apple.com (ApacheTrafficServer/8.0.5), https/1.1 ussjc2-vp-vfe-008.ts.apple.com (ApacheTrafficServer/8.0.5), http/1.1 usscz2-edge-lx-002.ts.apple.com (ApacheTrafficServer/8.0.5), http/1.1 usscz2-edge-bx-042.ts.apple.com (ApacheTrafficServer/8.0.5)
Date: Sat, 05 Oct 2019 04:17:18 GMT
X-DLB-Upstream: 10.117.108.197:8082
x-icloud-versionid: 7cfb0240-e4b1-11e9-a9f3-d8c497a3592d
Connection: close
Access-Control-Expose-Headers: *
X-Apple-Cache-Session: SZOOPklKmDIW
X-Apple-Request-UUID: cc5994da-d626-4a31-be5f-bc3c8ac905e4, cc5994da-d626-4a31-be5f-bc3c8ac905e4
Access-control-max-age: 3000
CDNUUID: 18fac378-7a8d-496d-9c22-1d09eeb6b56b-990994976
Content-Type: application/octet-stream
X-Cache: miss, hit-fresh, miss, hit-fresh
Access-control-allow-credentials: false
Last-Modified: Wed, 02 Oct 2019 01:10:56 GMT
Etag: "04E6B949F0F06043F454792436ACF09D-3"
```

It seems that the hostname is in the `source` query parameter, and the access key is somehow passed along (I have yet to figure out the end result URL that the cache server primes it's cache with).

A few things to note, the path of the request seems to be the path of the asset on the source, I haven't quite figured out how that works yet, as it seems like an odd choice.

The actual download protocol is still in the works, but it seems as though the client can download while the server is also caching something. Also, note the availability of range requests, which means the client can request ranges of bytes from the request.

All in all, it seems like a really interesting caching API. More to come soon.
