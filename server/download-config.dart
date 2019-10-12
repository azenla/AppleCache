import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  var client = new HttpClient();
  var request = await client.getUrl(Uri.parse("http://suconfig.apple.com/resource/registration/v1/config.plist"));
  var response = await request.close();
  var signedXmlBase64 = (await utf8.decodeStream(response)).replaceAll("\n", "");
  var signedXmlContent = base64.decode(signedXmlBase64);
  var xmlBytes = signedXmlContent.sublist(64);
  var xml = const Utf8Decoder(allowMalformed: true).convert(xmlBytes);
  xml = xml.substring(0, xml.lastIndexOf("</plist>") + 8);
  print(xml);
  client.close();
}
