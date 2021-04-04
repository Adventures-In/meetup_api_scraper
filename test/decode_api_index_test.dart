import 'dart:io';

import 'package:html/parser.dart';
import 'package:test/test.dart';

void main() {
  group('Decoder', () {
    test('decodeApiIndex decodes api index data', () async {
      /// The file [api-index.html] is the result of retrieving the html from
      /// 'https://www.meetup.com/meetup_api/docs/' and getting the element
      /// with id=''api-index'
      final htmlString = await File('test/data/api-index.html').readAsString();
      final indexSectionElement = parse(htmlString).documentElement!;

      // final decoder = Decoder();
      // final endpointInfoList =
      //     await decoder.decodeApiIndex(apiIndexSectionElement);

      for (final tag in indexSectionElement.getElementsByTagName('a')) {
        print(tag.children.elementAt(1).text);
      }
    });
  });
}
