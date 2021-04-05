import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:meetup_api_scraper/models/endpoint_info.dart';
import 'package:meetup_api_scraper/utils/path_utils.dart';
import 'package:meetup_api_scraper/extensions/document_extensions.dart';

const httpsScheme = 'https';
const meetupHost = 'www.meetup.com';
const docsPath = '/meetup_api/docs/';

class EndpointsScraper {
  EndpointsScraper({required Client client}) : _client = client;

  final Client _client;
  final List<EndpointInfo> _infos = [];

  // maps for collecting data during index scrape
  final Map<String, String> _sectionForPath = {};
  // final Map<String, List<String>> _idPrefixesForPath = {};

  /// Scrape each endpoint page, to get a list of EndpointInfo
  Future<List<EndpointInfo>> scrape() async {
    await _scrapeIndex();

    print('scraped index');

    for (final path in _sectionForPath.keys) {
      await _scrapeEndpoint(path);
      print('scraped endpoint at: $path');
    }

    return _infos;
  }

  /// The API index is on the first page at /meetup_api/docs/ and lists all
  /// of the endpoints.
  ///
  /// Here we retrieve the html document and extract the element that holds
  /// the API index section, then scrape and save relevant data.
  Future<void> _scrapeIndex() async {
    final response = await _client
        .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath));
    final document = parse(response.body);
    final indexElement = document.getElementById('api-index')!;

    /// Put all of the urls into a set & map each one to the section it is in
    ///
    /// The sections will be used to create classes so a call becomes (eg.)
    /// client.events.openRSVPs()
    for (final tag in indexElement.getElementsByTagName('h4')) {
      final section = tag.text;
      for (final child in tag.nextElementSibling?.children ?? <Element>[]) {
        final endpointPath = child.children.first.children.elementAt(1).text;
        _sectionForPath[endpointPath] = section;

        // // store the idPrefixes for each path
        // final operatonTypeString =
        //     child.children.first.children.elementAt(0).text;
        // final operationTypeEnum = OperationTypeEnum.from(operatonTypeString);
        // (_idPrefixesForPath[endpointPath] ??= <String>[])
        //     .add(OperationTypeEnum.idValueOf[operationTypeEnum]!);
      }
    }
  }

  /// Retrieve the html document at the endpoint documentation page and extract
  /// the element that holds the relevant info.
  Future<void> _scrapeEndpoint(String path) async {
    final response = await _client
        .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath + path));
    final document = parse(response.body);

    for (var i = 0; i < document.numberOfInfos; i++) {
      _infos.add(document.toEndpointInfo(i, path));
    }
  }

  Future<void> savePartialScrapeForTestData() async {
    // get the indexes data
    await _scrapeIndex();

    // iterate over the paths, retrieving each page and writing each 'info'
    // element to file
    for (final path in _sectionForPath.keys) {
      final response = await _client.get(
          Uri(scheme: httpsScheme, host: meetupHost, path: docsPath + path));
      final infosElement = parse(response.body).getElementById('method-info')!;

      await File(PathUtils.testDataPathFrom(path))
          .writeAsString(infosElement.outerHtml);
    }
  }
}
