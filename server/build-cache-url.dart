void main(List<String> args) {
  var cacheServerUrl = Uri.parse(args[0]);
  var sourceDataUrl = Uri.parse(args[1]);

  var url = cacheServerUrl.replace(path: sourceDataUrl.path, queryParameters: {
    "source": sourceDataUrl.host
  }..addAll(sourceDataUrl.queryParameters));
  print(url);
}
