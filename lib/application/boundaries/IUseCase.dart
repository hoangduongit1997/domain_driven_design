import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/domain/value_objects/Failure.dart';

abstract class IUseCase<TUseCaseInput, TUseCaseOuput> {
  Future<Either<Failure, TUseCaseOuput>> execute(TUseCaseInput input);
}
