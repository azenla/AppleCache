# Content Cache Locator

The locator is the service that provides a list of registered local caches.

Oddly, Apple chose to register the caches based on the public IP address of the
registered cache.

The locator service URL is: `https://lcdn-locator.apple.com/lcdn/locate`

The request JSON to locate all the caches is:

```json
{
    "ranked-results": true,
    "locator-tag": "#f5cfd4d0", // Seems to be different each time.
    "local-addresses": [
      "10.0.0.60" // My local address.
    ],
    "public-address-ranges": [
      []
    ],
    "locator-software": [
      {
        "build": "19A578c",
        "type": "system",
        "name": "Mac OS X",
        "version": "10.15"
      },
      {
        "id": "com.apple.AssetCacheLocatorService",
        "executable": "AssetCacheLocatorService",
        "type": "bundle",
        "name": "AssetCacheLocatorService",
        "version": "106.1"
      }
    ]
}
```

The response looks similar to:

```json
{
  "connect-timeout": 0.75,
  "servers": [
    {
      "address": "10.0.0.60",
      "port": 54459,
      "guid": "C881402D-001C-49BD-8672-7BA84A69C9AB",
      "version": "233",
      "connect-timeout": 0.5,
      "details": {
        "capabilities": {
          "ur": true,
          "sc": true,
          "pc": true,
          "im": true,
          "ns": true,
          "query-parameters": true
        },
        "cache-size": 150000000000,
        "ac-power": true,
        "is-portable": true,
        "local-network": [
          {
            "speed": 30,
            "wired": false
          }
        ]
      },
      "rank": 1
    }
  ],
  "validity-interval": 3600
}
```

## Notes

Given the usage of public IPs as the way to differentiate between caches,
I wonder if it would be possible to use shared VPNs and receive a list
of caches on the shared VPN. This is quite concerning, though likely has
no actual security impact given that the local clients should not be available
between VPN clients.

Also, the reason that Apple seems to register content caches at all is related to
region restriction control of cached content (movies that aren't available in certain regions.)

Frankly, I believe that Apple should reconsider this system and use mDNS to discover content caches. It just makes more sense, and Apple already uses mDNS (because of Bonjour), so why not?
