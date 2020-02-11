library yaml_serializer;

var plainStringNotAllowed = [
  '#',
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
    var val = value.toString();
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
    str += key + ': ' + val + '\n';
  });
  return str;
}
