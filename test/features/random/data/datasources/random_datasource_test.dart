import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:chuck_norris_io/core/network/server_api_client.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:nock/nock.dart';

void randomDataSourceTest() {
  group('datasource test layer', () {
    late RandomClientImpl randomClient;
    late ServerApiClient serverApiClient;

    setUp(() {
      serverApiClient = ServerApiClient(
        networkInfoRepository: getIt<NetworkInfoRepository>(),
      );
      randomClient = RandomClientImpl(apiClient: serverApiClient);
    });

    test('getRandom should return a Response', () async {
      final interceptor = nock.get("/jokes/random")
        ..reply(200, 'response body');

      final response = await randomClient.getRandom();

      expect(interceptor.isDone, true);
      expect(response, isA<Response>());
    });
  });
}
