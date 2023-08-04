import 'package:chuck_norris_io/core/network/server_api_client.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:http/http.dart';

class RandomClientImpl implements RandomClient {
  final ServerApiClient apiClient;

  RandomClientImpl({
    required this.apiClient,
  });

  @override
  Future<Response> getRandom() async {
    final response = await apiClient.get('/jokes/random');
    return response;
  }
}
