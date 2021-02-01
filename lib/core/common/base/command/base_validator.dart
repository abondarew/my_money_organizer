abstract class BaseCommandValidator<T> {
  Future<void> validate(T command);
}
