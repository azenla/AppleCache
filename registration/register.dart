import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  var client = new HttpClient();
  var request = await client
      .postUrl(Uri.parse("https://lcdn-registration.apple.com/lcdn/register"));
  request.write(json.encode({
    "push-token": "fbFqxPukE8hfZD+Lbeo+E6390ih2lmY0I13apvLhZ6I=",
    "ranked-peers": true,
    "details": {
      "capabilities": {
        "ur": true,
        "sc": true,
        "pc": true,
        "im": true,
        "ns": true,
        "query-parameters": true
      },
      "cache-size": 230000000000,
      "ac-power": true,
      "is-portable": true,
      "local-network": [
        {"speed": 1300, "wired": false}
      ]
    },
    "local-ranges-only": true,
    "local-ranges": [
      {"first": "10.0.0.0", "last": "10.0.255.255"}
    ],
    "cache-software": [
      {"type": "cache", "name": "Caching Server", "version": "233"},
      {
        "build": "19A583",
        "type": "system",
        "name": "Mac OS X",
        "version": "10.15"
      }
    ],
    "guid": "A14862D9-9643-4F18-B0BA-990BC2CAC0C2",
    "local-addresses": [
      {"address": "10.0.0.20", "netmask": "255.255.0.0", "port": "51391"}
    ],
    "session-token":
        "1570938452471~46E0EE91164ABF1E4D42F7C3DC51B0747AD1BC3E7C9073CB6230D8F2191C40D9"
  }));
  var response = await request.close();
  var result = await utf8.decodeStream(response);
  print(result);
  client.close();
}
