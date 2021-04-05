import 'package:html/dom.dart';
import 'package:meetup_api_scraper/enums/operation_type.dart';

extension ElementExtension on Element {
  OperationType operationTypeAtPosition(int position) =>
      OperationTypeEnum.from(querySelectorAll(r'div[title="Request URI"]')
          .elementAt(position)
          .text
          .trim()
          .split(' ')
          .first);

  Element? get nextDescriptionList {
    final allNodes = parentNode!.nodes;
    final remainingNodes = allNodes.sublist(allNodes.indexOf(this) + 1);

    for (final node in remainingNodes) {
      if (node is Element && node.localName == 'dl') {
        return node;
      }
    }

    return null;
  }
}
