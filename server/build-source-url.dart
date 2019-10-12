void main(List<String> args) {
  var cacheServerUrl = Uri.parse(args[0]);

  var sourceHost = cacheServerUrl.queryParameters["source"];
  var newUrlParams = new Map<String, String>.from(cacheServerUrl.queryParameters);
  newUrlParams.remove("source");

  var url = cacheServerUrl.replace(scheme: "http", port: 443, host: sourceHost, queryParameters: newUrlParams);
  var urlString = url.toString();
  if (urlString.endsWith("?")) {
    urlString = urlString.substring(0, urlString.length - 1);
  }
  print(urlString);
}
