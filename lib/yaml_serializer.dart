library yaml_serializer;

String toYAML(Map<String, dynamic> map) {
  var str = '';

  map.forEach((key, value) {
    var val = value.toString();
    if (val.contains('#')) {
      val = "'" + val + "'";
    }
    str += key + ': ' + val + '\n';
  });
  return str;
}
