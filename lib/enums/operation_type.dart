enum OperationType { post, get, delete, patch, unknown }

class OperationTypeEnum {
  static OperationType from(String s) {
    for (final enumValue in OperationType.values) {
      if (enumValue.toString() == 'OperationType.${s.toLowerCase()}') {
        return enumValue;
      }
    }
    return OperationType.unknown;
  }
}
