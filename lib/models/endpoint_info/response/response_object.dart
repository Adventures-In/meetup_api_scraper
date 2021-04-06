import 'package:html/dom.dart';

class ResponseObject {
  late final String _description;
  late final Map<String, ResponseObject>? _map;

  ResponseObject.fromElement(Element element) {
    final children = element.children;

    _description = children.first.text;

    // if this is a leaf, ie. with only a description and no sublist, return
    if (children.length < 2) {
      _map = null;
      return;
    }

    final sublist = children.last.children;
    final localMap = <String, ResponseObject>{};
    for (var i = 0; i < sublist.length - 1; i += 2) {
      final dt = sublist[i];
      final dd = sublist[i + 1];
      localMap[dt.text.trim()] = ResponseObject.fromElement(dd);
    }

    _map = localMap;
  }

  bool get isLeaf => _map == null;
  Map<String, ResponseObject> get map => _map!;
  String get description => _description;

  @override
  String toString() =>
      (_map == null) ? '$_description\n' : '$_description\n\n$_map';
}
