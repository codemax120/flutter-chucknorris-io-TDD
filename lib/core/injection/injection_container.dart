import 'package:chuck_norris_io/core/network/network_info.dart';
import 'package:chuck_norris_io/core/network/server_api_client.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource.dart';
import 'package:chuck_norris_io/features/random/data/datasources/random_datasource_impl.dart';
import 'package:chuck_norris_io/features/random/data/repositories/random_repository_impl.dart';
import 'package:chuck_norris_io/features/random/domain/repositories/random_repository.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:chuck_norris_io/features/random/presentation/bloc/random_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initDependecies() {
  // Network Handler
  getIt.registerLazySingleton<NetworkInfoRepository>(
    () => NetworkInfoRepositoryImpl(),
  );
  // Server API Client
  getIt.registerLazySingleton(
    () => ServerApiClient(
      networkInfoRepository: getIt(),
    ),
  );
}

Future<void> initDependencies() async {
  getIt.pushNewScope();
  await initRandom();
}

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
