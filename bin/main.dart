import 'dart:io';

import 'package:meetup_api_scraper/meetup_api_scraper.dart'
    as meetup_api_scraper;

import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

Future<Element?> retrieveApiIndexTags() async {
  final client = Client();
  // final response = await client.get(
  //     Uri(scheme: 'https', host: 'www.meetup.com', path: '/meetup_api/docs/'));

  final response = await client.get(Uri(
      scheme: 'https',
      host: 'www.meetup.com',
      path: '/meetup_api/docs/:urlname/abuse_reports/'));

  // Use html parser and query selector
  final document = parse(response.body);
  // return document.getElementById('api-index');

  return document.getElementById('method-info');
}

void main(List<String> arguments) async {
  // final tags = await retrieveApiIndexTags();

  // print(tags?.innerHtml);

  await writeFile();
}

Future<File> writeFile() {
  var contents = '''
{
  "openapi" : "3.0.1",
  
  "externalDocs" : {
    "description": "Meetup API Documentation",
    "url": "https://www.meetup.com/meetup_api/"
  },
  
  
  "info" : {
    "title" : "Meetup API",
    "version" : "3"
  },


  "servers" : [ {
    "url" : "https://api.meetup.com/"
  } ],

  "paths" : {
''';

  contents += '''
  }
}
''';

  return File('output/openapi.json').writeAsString(contents);
}
