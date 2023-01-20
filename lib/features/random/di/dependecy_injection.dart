import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource_impl.dart';
import 'package:chuck_norris_io/features/random/data/repositories/random_repository_impl.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';

Future<void> initRandom() async {
  getIt.registerLazySingleton(() => RandomBloc(
        getRandomUseCase: getIt(),
      ));

  getIt.registerLazySingleton(() => GetRandomUseCase(repository: getIt()));

  getIt.registerLazySingleton<RandomClient>(() => RandomClientImpl(
        apiClient: getIt(),
      ));

  getIt.registerLazySingleton<RandomRepository>(() => RandomRepositoryImpl(
        randomClient: getIt(),
      ));
}
