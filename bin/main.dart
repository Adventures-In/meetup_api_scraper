import 'dart:io';
import 'dart:convert';

import 'package:meetup_api_scraper/api_tags.dart';

void main(List<String> arguments) async {
  final tags = await ApiTags().retrieveApiIndexTags();

  print(tags.innerHtml);

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
