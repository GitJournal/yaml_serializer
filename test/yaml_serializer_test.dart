import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:yaml_serializer/yaml_serializer.dart';

void main() {
  test('Basic Test', () {
    var map = {
      'title': 'foo',
      'version': 1,
    };
    var expectedOutput = '''title: foo
version: 1
''';
    expect(toYAML(map), expectedOutput);
    expect(loadYaml(expectedOutput), map);
  });

  test('Avoid # in strings', () {
    var map = {
      'title': 'foo #bar',
      'version': 1,
    };
    var expectedOutput = '''title: 'foo #bar'
version: 1
''';
    expect(toYAML(map), expectedOutput);
    expect(loadYaml(expectedOutput), map);
  });

  test("Escape ' correctly", () {
    var map = {
      'title': "foo #bar's fire",
      'version': 1,
    };
    var expectedOutput = '''title: 'foo #bar''s fire'
version: 1
''';
    expect(toYAML(map), expectedOutput);
    expect(loadYaml(expectedOutput), map);
  });

  test('Escape : correctly', () {
    var map = {
      'title': 'TODO: work',
      'version': 1,
    };
    var expectedOutput = '''title: 'TODO: work'
version: 1
''';
    expect(toYAML(map), expectedOutput);
    expect(loadYaml(expectedOutput), map);
  });

  test('Do not always escape :', () {
    var map = {
      'title': 'TODO:work',
      'version': 1,
    };
    var expectedOutput = '''title: TODO:work
version: 1
''';
    expect(toYAML(map), expectedOutput);
    expect(loadYaml(expectedOutput), map);
  });
}
