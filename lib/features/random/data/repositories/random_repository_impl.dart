import 'dart:convert';

import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/data/models/random.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:dartz/dartz.dart';

class RandomRepositoryImpl implements RandomRepository {
  final RandomClient randomClient;

  RandomRepositoryImpl({
    required this.randomClient,
  });

  @override
  Future<Either<Failure, RandomEntity>> getRandom() async {
    try {
      final response = await randomClient.getRandom();

      if (response.statusCode == 200) {
        final decodedResp = RandomModel.fromJson(jsonDecode(response.body));
        return Right(decodedResp);
      }
      return Left(ServerFailure());
    } on Object {
      return Left(ServerFailure());
    }
  }
}
