import 'package:html/dom.dart';

class Examples {
  final String _notes;
  final String _example;

  Examples.fromElement(Element element)
      : _notes = element.text,
        _example = element.nextElementSibling?.text ?? '-';

  String get notes => _notes;
  String get example => _example;

  @override
  String toString() => '$_notes\n$_example';
}
