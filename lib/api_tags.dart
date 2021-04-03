import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class ApiTags {
  /// The API documentation opens with a list where each item is an index into a
  /// detail view
  late final Element indexTags;

  static Future<Element?> retrieveApiIndexTags() async {
    final client = Client();
    final response = await client.get(Uri(
        scheme: 'https', host: 'www.meetup.com', path: '/meetup_api/docs/'));

    // Use html parser and query selector
    final document = parse(response.body);
    final indexTags = document.getElementById('api-index');

    return indexTags;
  }

  static Future<Element?> retrieveApiDetailTags() async {
    // return document.getElementById('method-info');
  }
}
