import 'package:html/dom.dart';

class Response {
  late final String _description;
  late final Map<String, Object> map;

  Response.fromElement(Element element) {
    _description = element.text;

    final nodes = element.parentNode!.nodes;
    for (var i = nodes.indexOf(element) + 1; i < nodes.length; i++) {
      final node = nodes[i];
      if (node is Element) {
        print(node.text);
      }
    }

    map = {};
  }

  String get description => _description;

  @override
  String toString() => _description;
}
