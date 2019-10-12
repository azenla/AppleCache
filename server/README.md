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
GET /2019FallSeed/mobileassets/061-28461/73D248DA-E92B-11E9-87BD-36A73FE00C7B/com_apple_MobileAsset_SoftwareUpdateDocumentation/a080e3173e75180afa7ea1a15f469ed839f60260.zip?source=updates-http.cdn-apple.com HTTP/1.1
Host: 10.0.0.60:54459
Accept: */*
Accept-Language: en-us
Connection: keep-alive
Accept-Encoding: gzip, deflate
User-Agent: nsurlsessiond/1115 CFNetwork/1115 Darwin/19.0.0

HTTP/1.1 200 OK
X-Apple-Cached-Ranges: D885102C-110C-49BD-8672-7EF84A49C9AA bytes=0-732588
Via: http/1.1 usscz2-edge-bx-018.ts.apple.com (ApacheTrafficServer/8.0.5)
Server: ATS/8.0.5
X-Apple-Cache-Session: ndEDkMdIUkiv
CDNUUID: 64c7e0da-fa45-4fa1-bc6b-55d04acb9c21-986340707
Date: Sat, 12 Oct 2019 08:39:36 GMT
Cache-Control: max-age=31536000
Content-Length: 732589
Connection: close
Etag: "bcb052bdb592142336fa33e674dca44b"
Accept-Ranges: bytes
X-Cache: hit-fresh
```

It seems that the hostname is in the `source` query parameter.

A few things to note, the path of the request seems to be the path of the asset on the source. To reconstruct the URL, retain all query parameters except for `source`, and use the hostname in the `source` query parameter. For example:

```text
Cache URL: http://10.0.0.60:54439/2019FallSeed/mobileassets/061-28461/73D248DA-E92B-11E9-87BD-36A73FE00C7B/com_apple_MobileAsset_SoftwareUpdateDocumentation/a080e3173e75180afa7ea1a15f469ed839f60260.zip?source=updates-http.cdn-apple.com

Source URL: http://updates-http.cdn-apple.com:443/2019FallSeed/mobileassets/061-28461/73D248DA-E92B-11E9-87BD-36A73FE00C7B/com_apple_MobileAsset_SoftwareUpdateDocumentation/a080e3173e75180afa7ea1a15f469ed839f60260.zip
```

The cache server should then download the URL if it is not in the cache, and stream the results while downloading.

All in all, it seems like a really interesting caching API. More to come soon.
