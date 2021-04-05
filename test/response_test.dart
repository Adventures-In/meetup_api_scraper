import 'dart:io';

import 'package:html/parser.dart';
import 'package:meetup_api_scraper/models/endpoint_info/response.dart';
import 'package:meetup_api_scraper/utils/path_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Response', () {
    test('correctly parses a complex Response object', () async {
      final path = '/members/:member_id';
      final testDataPath = PathUtils.testDataPathFrom(path);
      final htmlString = await File(testDataPath).readAsString();
      final document = parse(htmlString);

      final responseElement = document.getElementById('getresponse')!;

      final response = Response.fromElement(responseElement);

      expect(response.map.keys, ['bio', 'birthday', 'city']);
    });
  });
}
