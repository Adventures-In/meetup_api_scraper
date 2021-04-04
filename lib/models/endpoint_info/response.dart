import 'package:html/dom.dart';

class Response {
  final String _description;

  Response.fromElement(Element element) : _description = element.text;

  String get description => _description;

  @override
  String toString() => _description;
}
