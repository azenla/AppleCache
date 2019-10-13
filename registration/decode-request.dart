import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  var signedRequestBase64 = (await new File("request.b64").readAsString()).trim();
  var signedJsonContent = base64.decode(signedRequestBase64);
  var jsonContent = const Utf8Decoder(allowMalformed: true).convert(signedJsonContent);
  jsonContent = jsonContent.substring(jsonContent.indexOf('{"'), jsonContent.lastIndexOf('"}') + 2);
  print(jsonContent);
}
