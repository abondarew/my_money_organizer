class BaseQueryExceptions implements Exception {}

class InvalidQueryException implements BaseQueryExceptions {
  final String? message;

  InvalidQueryException([this.message]);

  @override
  String toString() {
    return message == null
        ? "InvalidQueryException"
        : "InvalidQueryException: " + this.message!;
  }
}
