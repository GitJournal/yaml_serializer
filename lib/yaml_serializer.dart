library yaml_serializer;

var plainStringNotAllowed = [
  ' #',
  ': ',
  '? ',
  '- ',
  '[',
  ']',
  '{',
  '}',
  ',',
];

String toYAML(Map<String, dynamic> map) {
  var str = '';

  map.forEach((key, value) {
    var val = '';
    if (value is List) {
      var items = <String>[];
      for (var v in value) {
        items.add(_toYamlString(v));
      }
      val = '[' + items.join(', ') + ']';
    } else {
      val = _toYamlString(value.toString());
    }
    str += key + ': ' + val + '\n';
  });
  return str;
}

String _toYamlString(String val) {
  var mustEscape = false;
  for (var s in plainStringNotAllowed) {
    if (val.contains(s)) {
      mustEscape = true;
      break;
    }
  }
  if (mustEscape) {
    if (val.contains("'")) {
      val = val.replaceAll("'", "''");
    }
    val = "'" + val + "'";
  }
  return val;
}
