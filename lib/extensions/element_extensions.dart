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
}
