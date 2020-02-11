import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:yaml_serializer/yaml_serializer.dart';

void main() {
  test('Basic Test', () async {
    final dir = Directory('test/data/');
    var lister = dir.list(recursive: false, followLinks: false);
    await for (var fsEntity in lister) {
      var file = fsEntity as File;
      var input = await file.readAsString();

      var map = <String, dynamic>{};
      var yamlMap = loadYaml(input);
      yamlMap.forEach((key, value) {
        map[key] = value;
      });
      print('Testing ${fsEntity.path}');
      expect(toYAML(map), input);
    }
  });
}
