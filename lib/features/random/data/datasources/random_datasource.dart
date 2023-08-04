import 'package:http/http.dart';

abstract class RandomClient {
  Future<Response> getRandom();
}
