import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

const httpsScheme = 'https';
const meetupHost = 'www.meetup.com';
const docsPath = '/meetup_api/docs/';

class Scraper {
  final client = Client();

  // Retrieve the html document at the endpoint documentation page and extract
  // the element that holds the relevant info.
  Future<Element> scrape({required String endpoint}) async {
    final response = await client.get(
        Uri(scheme: httpsScheme, host: meetupHost, path: docsPath + endpoint));
    return parse(response.body).getElementById('method-info') ??
        Element.tag('empty');
  }

  // Retrieve the html document at the main documentation page and extract
  // the element tha holds the API index section.
  Future<Element> scrapeApiIndex() async {
    final response = await client
        .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath));
    return parse(response.body).getElementById('api-index') ??
        Element.tag('empty');
  }
}
