import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class ApiTags {
  static const httpsScheme = 'https';
  static const meetupHost = 'www.meetup.com';
  static const docsPath = '/meetup_api/docs/';

  final client = Client();

  /// The API documentation opens with a list where each item is an index into a
  /// detail view
  late final Element indexTags;

  Future<Element> retrieveApiIndexTags() async {
    final response = await client
        .get(Uri(scheme: httpsScheme, host: meetupHost, path: docsPath));

    // Use html parser and query selector
    final document = parse(response.body);
    final indexTags = document.getElementById('api-index');

    return indexTags ?? Element.tag('empty');
  }

  Future<Element> retrieveApiDetailTags(String endpoint) async {
    final response = await client.get(
        Uri(scheme: httpsScheme, host: meetupHost, path: docsPath + endpoint));
    final document = parse(response.body);
    return document.getElementById('method-info') ?? Element.tag('empty');
  }
}
