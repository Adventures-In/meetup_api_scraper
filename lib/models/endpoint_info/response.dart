import 'package:html/dom.dart';

class Response {
  late final String _description;
  late final Map<String, Object> map;

  Response.fromElement(Element element) {
    final nodes = element.parentNode!.nodes;
    final firstElement = nodes.first as Element;
    if (firstElement.className == 'p') _description = firstElement.text;
  }

  String get description => _description;

  @override
  String toString() => _description;
}
