import 'package:html/dom.dart';

class ResponseObject {
  late final String _description;
  late final Map<String, ResponseObject>? _map;

  ResponseObject.fromElement(Element element) {
    final children = element.children;

    _description = children.first.text;

    if (children.length < 2) {
      _map = null;
      return;
    }

    final localMap = <String, ResponseObject>{};
    for (var i = 0; i < children.length; i += 2) {
      final dt = children[i];
      final dd = children[i + 1];
      localMap[dt.text.trim()] = ResponseObject.fromElement(dd);
    }

    _map = localMap;
  }

  bool get isLeaf => _map == null;
  Map<String, ResponseObject> get map => _map!;
  String get description => _description;
}
