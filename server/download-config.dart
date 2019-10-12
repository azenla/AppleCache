
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  var client = new HttpClient();
  var request = await client.getUrl(Uri.parse("http://suconfig.apple.com/resource/registration/v1/config.plist"));
  var response = await request.close();
  var signedXmlBase64 = await utf8.decodeStream(response);
  var begin = signedXmlBase64.substring(85);
  print(begin);
  client.close();
}

