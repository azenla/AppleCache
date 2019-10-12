import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  var client = new HttpClient();
  var request = await client
      .postUrl(Uri.parse("https://lcdn-locator.apple.com/lcdn/locate"));
  request.writeln(json.encode({
    "ranked-results": true,
    "locator-tag": "#f5cfd4d0",
    "local-addresses": [args[0]],
    "public-address-ranges": [[]],
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
  }));
  var response = await request.close();
  var content = await utf8.decodeStream(response);
  var data = json.decode(content);
  print(const JsonEncoder.withIndent("  ").convert(data));
  client.close();
}
