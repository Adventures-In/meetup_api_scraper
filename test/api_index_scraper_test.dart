import 'dart:io';

import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  group('Scraper', () {
    test('works', () async {
      /// The file [api-index.html] is the result of retrieving the html from
      /// 'https://www.meetup.com/meetup_api/docs/' and getting the element
      /// with id=''api-index'
      final htmlString = await File('test/data/api-index.html').readAsString();
      final htmlDocument = parse(htmlString);

      final h3Tags = htmlDocument.querySelectorAll('h4');
      for (final element in h3Tags) {
        print('\n' + element.text + '\n');
        for (final child in element.nextElementSibling!.children) {
          print(child.className);
          print(child.children.first.attributes['href']);
          print(child.children.first.attributes['title']);
        }
      }
    });
  });
}
