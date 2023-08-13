import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void dependecyInjectionTest() {
  group('Random feature di layer', () {
    test('registers dependencies correctly', () {
      expect(getIt<RandomBloc>(), isA<RandomBloc>());
      expect(getIt<GetRandomUseCase>(), isA<GetRandomUseCase>());
      expect(getIt<RandomClient>(), isA<RandomClient>());
      expect(getIt<RandomRepository>(), isA<RandomRepository>());
    });
  });
}
