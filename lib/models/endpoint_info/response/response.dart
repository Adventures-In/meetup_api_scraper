import 'package:html/dom.dart';
import 'package:meetup_api_scraper/extensions/element_extensions.dart';
import 'package:meetup_api_scraper/models/endpoint_info/response/response_object.dart';

class Response {
  late final String _description;
  late final Map<String, ResponseObject>? _map;

  Response.fromElement(Element element) {
    _description = element.text;

    final dlChildren = element.nextDescriptionList!.children;

    final localMap = <String, ResponseObject>{};
    for (var i = 0; i < dlChildren.length; i += 2) {
      final dt = dlChildren[i];
      final dd = dlChildren[i + 1];
      localMap[dt.text.trim()] = ResponseObject.fromElement(dd);
    }

    _map = localMap;
  }

  String get description => _description;
  Map<String, ResponseObject> get map => _map!;

  @override
  String toString() => '$_description\n\n$_map';
}
