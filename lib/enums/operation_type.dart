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

  static const List<String> idValues = [
    'post',
    'get',
    'delete',
    'edit',
  ];

  static const Map<OperationType, String> idValueOf = {
    OperationType.post: 'post',
    OperationType.get: 'get',
    OperationType.delete: 'delete',
    OperationType.patch: 'edit',
  };
}
