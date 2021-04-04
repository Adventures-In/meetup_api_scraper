import 'package:html/dom.dart';
import 'package:quiver/core.dart';

class Parameter {
  final String _name;
  final String _description;

  Parameter.fromElement(Element element)
      : _name = element.text,
        _description = element.nextElementSibling?.text ?? '-';

  String get name => _name;
  String get description => _description;

  @override
  String toString() => '$_name: $_description';

  @override
  bool operator ==(o) =>
      o is Parameter && _name == o.name && _description == o.description;

  @override
  int get hashCode => hash2(_name.hashCode, _description.hashCode);
}
