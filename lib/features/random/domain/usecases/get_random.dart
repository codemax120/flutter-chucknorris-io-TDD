import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/core/usecases/usecase.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:dartz/dartz.dart';

class ParamsUseCaseGetRandom {
  const ParamsUseCaseGetRandom();
}

class GetRandomResult {
  final RandomEntity response;
  const GetRandomResult({
    required this.response,
  });
}

class GetRandomUseCase
    extends UseCase<GetRandomResult, ParamsUseCaseGetRandom> {
  final RandomRepository repository;

  GetRandomUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, GetRandomResult>> call(
      ParamsUseCaseGetRandom params) async {
    final checkResult = await repository.getRandom();

    return checkResult.fold(
      (failure) => Left(failure),
      (result) => Right(
        GetRandomResult(response: result),
      ),
    );
  }
}
