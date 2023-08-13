import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/core/usecases/usecase.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomUseCase extends UseCase<RandomEntity, NoParams> {
  final RandomRepository repository;

  GetRandomUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, RandomEntity>> call(NoParams params) async {
    final checkResult = await repository.getRandom();

    return checkResult.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
