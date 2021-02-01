abstract class BaseQueryValidator<Q> {
  Future<void> validate(Q query);
}
