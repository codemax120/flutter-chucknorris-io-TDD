import 'dart:convert';

import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/core/network/failure.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/data/models/random.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:nock/nock.dart';

void randomRepositoryImplTest() {
  group('random repository implement test', () {
    late RandomClient randomClient;

    setUp(() {
      randomClient = getIt<RandomClient>();
    });

    const String mockResponse = '''
      {
        "id": "123",
        "url": "https://example.com",
        "value": "Chuck Norris jokes are funny",
        "icon_url": "https://example.com/icon",
        "created_at": "2023-08-11",
        "updated_at": "2023-08-11",
        "categories": []
      }
    ''';

    test('should return a RandomEntity when the request is successful',
        () async {
      final interceptor = nock.get("/jokes/random")..reply(200, mockResponse);
      final response = await randomClient.getRandom();
      final decodedResp = RandomModel.fromJson(jsonDecode(response.body));

      expect(interceptor.isDone, true);
      expect(response, isA<Response>());
      expect(response.statusCode, equals(200));
      expect(Right(decodedResp), equals(Right(decodedResp)));
    });

    test('should return a RandomEntity when the request is not successful',
        () async {
      final interceptor = nock.get("/jokes/random")..reply(400, mockResponse);
      final response = await randomClient.getRandom();

      expect(interceptor.isDone, true);
      expect(response, isA<Response>());
      expect(response.statusCode, equals(400));
      expect(Left(ServerFailure()), equals(Left(ServerFailure())));
    });
  });
}
