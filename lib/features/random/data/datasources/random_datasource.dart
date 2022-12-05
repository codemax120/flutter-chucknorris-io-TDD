import 'package:chuck_norris_io/features/random/data/models/random.dart';

abstract class RandomClient {
  Future<RandomModel> getRandom();
}
