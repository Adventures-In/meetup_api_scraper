import 'dart:io';

import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  group('EndpointInfos', () {
    test('can be split by...', () async {
      final htmlString =
          await File('test/data/_members_:member_id.html').readAsString();

      final document = parse(htmlString);

      final h2s = document.getElementsByTagName('h2');
      for (final element in h2s) {
        final title = element.text;
        final id = element.parent?.id;
      }
    });
  });
}
