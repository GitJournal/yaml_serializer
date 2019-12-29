library yaml_serializer;

String toYAML(Map<String, dynamic> map) {
  var str = "";

  map.forEach((key, value) {
    String val = value.toString();
    str += key + ": " + val + "\n";
  });
  return str;
}
