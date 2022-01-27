library yaml_serializer;

import 'dart:convert';

import 'package:yaml/yaml.dart';

var plainStringNotAllowed = [
  ' #',
  ': ',
  '? ',
  '- ',
  '[',
  ']',
  '{',
  '}',
];

String toYAML(Map<String, dynamic> map) {
  var b = StringBuffer();

  for (var e in map.entries) {
    var key = e.key;
    var value = e.value;

    var val = '';
    if (value is List) {
      var items = <String>[];
      for (var v in value) {
        if (v is YamlList) {
          items.add(v.toString());
        } else {
          items.add(_toYamlString(v.toString()));
        }
      }
      val = '[' + items.join(', ') + ']';
    } else if (value is Map) {
      if (value is YamlMap) {
        value = _convertMap(value);
      }
      val = _indentString(toYAML(value as Map<String, dynamic>), 2);
      b.writeln(key + ':\n' + val);
      continue;
    } else {
      val = _toYamlString(value.toString());
    }
    b.writeln(key + ': ' + val);
  }
  return b.toString();
}

String _toYamlString(String val) {
  var mustEscape = false;
  for (var s in plainStringNotAllowed) {
    if (val.contains(s)) {
      mustEscape = true;
      break;
    }
  }
  if (val.startsWith('#')) {
    mustEscape = true;
  }

  if (mustEscape) {
    if (val.contains("'")) {
      val = val.replaceAll("'", "''");
    }
    val = "'" + val + "'";
  }
  return val;
}

Map<String, dynamic> _convertMap(YamlMap yamlMap) {
  var map = <String, dynamic>{};

  yamlMap.forEach((key, value) {
    if (value is YamlMap) {
      value = _convertMap(value);
    }
    map[key] = value;
  });

  return map;
}

String _indentString(String str, int numSpaces) {
  var indent = '';
  for (var i = 0; i < numSpaces; i++) {
    indent += ' ';
  }

  var lines = LineSplitter.split(str);
  lines = lines.map((e) => '$indent$e');
  return lines.join('\n');
}
