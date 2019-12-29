import 'package:test/test.dart';

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
  });
}
