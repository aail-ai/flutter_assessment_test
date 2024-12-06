/// Abstract class for usecase implementation
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams {}
