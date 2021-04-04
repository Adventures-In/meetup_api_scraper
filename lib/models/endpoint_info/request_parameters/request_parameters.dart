import 'package:html/dom.dart';
import 'package:meetup_api_scraper/models/endpoint_info/request_parameters/parameter.dart';
import 'package:quiver/collection.dart';
import 'package:quiver/core.dart';

class RequestParameters {
  final String _notes;
  final Set<Parameter> _parameterSet;

  RequestParameters.fromElement(Element element)
      : _notes = element.text,
        _parameterSet = element.nextElementSibling?.children
                .where((element) => element.localName == 'dt')
                .map((child) => Parameter.fromElement(child))
                .toSet() ??
            {};

  String get notes => _notes;
  Set<Parameter> get parameterSet => _parameterSet;

  @override
  String toString() =>
      '\n - notes: $_notes\n - parameterSet: \n  - ${_parameterSet.join('\n  - ')}';

  @override
  bool operator ==(o) =>
      o is RequestParameters &&
      _notes == o.notes &&
      setsEqual(_parameterSet, o._parameterSet);

  @override
  int get hashCode => hash2(_notes.hashCode, hashObjects(_parameterSet));
}
