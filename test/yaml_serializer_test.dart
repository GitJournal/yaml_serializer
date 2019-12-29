import 'package:test/test.dart';

import 'package:yaml_serializer/yaml_serializer.dart';

void main() {
  test('Basic Test', () {
    var map = {
      'title': 'foo',
      'version': 1,
    };

    var output = toYAML(map);
    var expectedOutput = '''title: foo
version: 1
''';

    expect(output, expectedOutput);
  });

  test('Avoid # in strings', () {
    var map = {
      'title': 'foo #bar',
      'version': 1,
    };

    var output = toYAML(map);
    var expectedOutput = '''title: 'foo #bar'
version: 1
''';

    expect(output, expectedOutput);
  });
}
