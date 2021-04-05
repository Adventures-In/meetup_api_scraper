import 'package:html/dom.dart';
import 'package:meetup_api_scraper/models/endpoint_info.dart';
import 'package:meetup_api_scraper/extensions/element_extensions.dart';

extension DocumentExtension on Document {
  int get numberOfInfos =>
      getElementById('method-info')!.getElementsByTagName('h2').length;

  EndpointInfo toEndpointInfo(int position, String path) {
    final infosElement = getElementById('method-info')!;

    // Each endpoint described in the page has a h2 tag
    final h2s = infosElement.getElementsByTagName('h2');

    final operationType = infosElement.operationTypeAtPosition(position);
    final title = h2s.elementAt(position).text;
    final idPrefix = h2s.elementAt(position).parent!.id;
    final summary = infosElement
        .getElementsByClassName('leading-top')
        .elementAt(position)
        .text;

    // The 3 major sections
    final paramsElement = getElementById('${idPrefix}params')!;
    final responseElement = getElementById('${idPrefix}response')!;
    final examplesElement = getElementById('${idPrefix}examples');

    return EndpointInfo(
        path: path,
        operationType: operationType,
        title: title,
        summary: summary,
        paramsElement: paramsElement,
        responseElement: responseElement,
        examplesElement: examplesElement);
  }
}
