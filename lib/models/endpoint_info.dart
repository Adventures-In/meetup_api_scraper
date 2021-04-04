import 'package:html/dom.dart';
import 'package:meetup_api_scraper/enums/operation_type.dart';
import 'package:meetup_api_scraper/models/endpoint_info/examples.dart';
import 'package:meetup_api_scraper/models/endpoint_info/request_parameters/request_parameters.dart';
import 'package:meetup_api_scraper/models/endpoint_info/response.dart';

// h2 - single tag => title
// final h2Tags = element.getElementsByTagName('h2');
// h3 - sections => Request Parameters, Response, Examples
// final h3Tags = element.getElementsByTagName('h3');
// h4 - none
class EndpointInfo {
  // Each endpoint has it's own page at meetup_api/docs/<endpoint>
  EndpointInfo(String title, String idPrefix, Document document, int position)
      : _title = title,
        _summary = document
            .getElementsByClassName('leading-top')
            .elementAt(position)
            .text {
    // elements that will be re-used
    final requestUriInfos = document
        .querySelectorAll(r'div[title="Request URI"]')
        .elementAt(position)
        .text
        .trim()
        .split(' ');

    // Request URI info at the start
    _path = requestUriInfos.last;
    _operationType = OperationTypeEnum.from(requestUriInfos.first);

    // The 3 major sections
    final paramsElement = document.getElementById('${idPrefix}params')!;
    final responseElement = document.getElementById('${idPrefix}response')!;
    final examplesElement = document.getElementById('${idPrefix}examples');
    _requestParameters =
        RequestParameters.fromElement(paramsElement.nextElementSibling!);
    _response = Response.fromElement(responseElement.nextElementSibling!);
    _examples = (examplesElement == null)
        ? null
        : Examples.fromElement(examplesElement.nextElementSibling!);
  }

  final String _title;
  final String _summary;
  late final String _path;
  late final OperationType _operationType;
  late final RequestParameters _requestParameters;
  late final Response _response;
  late final Examples? _examples;

  String get title => _title;
  String get summary => _summary;
  String get path => _path;
  OperationType get operationType => _operationType;
  RequestParameters get requestParameters => _requestParameters;
  Response get response => _response;
  Examples? get examples => _examples;

  @override
  String toString() =>
      'title: $_title\n\nsummary: $_summary\n\npath: $_path\n\noperationType: $_operationType\n\nrequestParameters: $_requestParameters\n\nresponse: $_response\n\n examples: $_examples';
}
