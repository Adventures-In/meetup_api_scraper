import 'dart:io';
import 'dart:convert';

import 'package:html/dom.dart';
import 'package:meetup_api_scraper/scraper.dart';

void main(List<String> arguments) async {
  final scraper = Scraper();

  // scrape each endpoint page, to get a list of endpointInfo in the section classes
  // create a client with a member for each section and each section class having a function for each endpoint
  // so a call becomes (eg.) client.events.openRSVPs()

  // The API index is on the first page at /meetup_api/docs/ and lists all
  // of the endpoints.
  final apiIndex = await scraper.scrapeApiIndex();

  final sectionFor = <String, String>{};
  final endpointPaths = <String>{};

  // put all of the urls into a set & map each one to the section it is in
  for (final tag in apiIndex.getElementsByTagName('h4')) {
    final section = tag.text;
    for (final child in tag.nextElementSibling?.children ?? <Element>[]) {
      final endpointPath = child.children.first.children.elementAt(1).text;
      sectionFor[endpointPath] = section;
      endpointPaths.add(endpointPath);
    }
  }

  final element = await scraper.scrape(endpoint: endpointPaths.first);

  print(element.outerHtml);

  // for (final path in endpointPaths) {
  //   final element = await scraper.scrape(endpoint: path);
  //   print(element.innerHtml);
  // }

  await writeFile();
}

Future<File> writeFile() {
  final openapiJsonMap = <String, dynamic>{
    'openapi': '3.0.1',
    'externalDocs': {
      'description': 'Meetup API Documentation',
      'url': 'https://www.meetup.com/meetup_api/'
    },
    'info': {'title': 'Meetup API', 'version': '3'},
    'servers': [
      {'url': 'https://api.meetup.com/'}
    ],
  };

  return File('output/openapi.json')
      .writeAsString(JsonEncoder.withIndent('  ').convert(openapiJsonMap));
}
