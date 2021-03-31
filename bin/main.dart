import 'dart:io';

import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

const httpsScheme = 'https';
const meetupHost = 'www.meetup.com';
const docsPath = '/meetup_api/docs/';

Future<Element?> retrieveApiIndexTags() async {
  final client = Client();

  final response = await client
      .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath));

  final document = parse(response.body);
  return document.getElementById('api-index');

  // final response = await client
  //     .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath+endpoint));
  // return document.getElementById('method-info');
}

void main(List<String> arguments) async {
  // final tags = await retrieveApiIndexTags();

  // print(tags?.innerHtml);

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
