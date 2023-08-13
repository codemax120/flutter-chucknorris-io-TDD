import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:chuck_norris_io/core/network/server_api_client.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void randomDataSourceImplTest() {
  late RandomClientImpl randomClient;
  late ServerApiClient serverApiClient;

  setUp(() {
    serverApiClient = ServerApiClient(
      networkInfoRepository: getIt<NetworkInfoRepository>(),
    );
    randomClient = RandomClientImpl(apiClient: serverApiClient);
  });

  group('datasource test layer', () {
    test('getRandom should call apiClient.get', () async {
      final interceptor = nock.get("/jokes/random")..reply(200, 'result');

      final response = await randomClient.getRandom();

      expect(interceptor.isDone, true);
      expect(response.statusCode, 200);
      expect(response.body, "result");
    });
    test('getRandom should handle error response', () async {
      final interceptor = nock.get("/jokes/random")
        ..reply(400, 'error message');

      final response = await randomClient.getRandom();

      expect(interceptor.isDone, true);
      expect(response.statusCode, 400);
      expect(response.body, "error message");
    });
  });
}
