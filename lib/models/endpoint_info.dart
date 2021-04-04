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
  final String _title;
  final String _summary;
  final String _path;
  final OperationType _operationType;
  final RequestParameters _requestParameters;
  final Response _response;
  final Examples? _examples;

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

  // Each endpoint has it's own page at meetup_api/docs/<endpoint>
  EndpointInfo.fromElement(Element element)
      : _title = element.getElementsByTagName('h2').first.text,
        _summary = element.getElementsByTagName('p').first.text,
        _path = element
                .querySelector(r'div[title="Request URI"]')
                ?.text
                .trim()
                .split(' ')
                .last ??
            '-',
        _operationType = OperationTypeEnum.from(element
                .querySelector(r'div[title="Request URI"]')
                ?.text
                .trim()
                .split(' ')
                .first ??
            ''),
        _requestParameters = RequestParameters.fromElement(
            element.getElementsByTagName('h3').first.nextElementSibling!),
        _response = Response.fromElement(element
            .getElementsByTagName('h3')
            .elementAt(1)
            .nextElementSibling!),
        _examples = (element.getElementsByTagName('h3').length > 2)
            ? Examples.fromElement(element
                .getElementsByTagName('h3')
                .elementAt(2)
                .nextElementSibling!)
            : null;
}
