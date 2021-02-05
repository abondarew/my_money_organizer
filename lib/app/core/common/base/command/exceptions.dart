class BaseCommandException implements Exception {}

class InvalidCommandException implements BaseCommandException{
  final String message;

  const InvalidCommandException ([this.message]);

  @override
  String toString() {
    if (this.message == null){
      return "InvalidCommandException";
    }
    return "InvalidCommandException: "+this.message;
  }
}
