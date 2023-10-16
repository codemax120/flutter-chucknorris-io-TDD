// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

import 'core/injection/injection_container_test.dart';
import 'core/network/exception_test.dart';
import 'core/network/failure_test.dart';
import 'core/network/network_info_test.dart';
import 'core/usecases/usecase_test.dart';
import 'features/main/common_main_test.dart';
import 'features/random/data/datasources/random_datasource_impl_test.dart';
import 'features/random/data/datasources/random_datasource_test.dart';
import 'features/random/data/models/random_model_test.dart';
import 'features/random/data/repositories/random_repository_impl_test.dart';
import 'features/random/di/dependecy_injection_test.dart';
import 'features/random/domain/entities/random_entitie_test.dart';
import 'features/random/domain/repositories/random_repository_test.dart';
import 'features/random/domain/usecases/get_random_test.dart';
import 'features/random/presentation/bloc/random_bloc_with_bloc_test.dart';
import 'features/random/presentation/bloc/random_bloc_without_bloc_test.dart';
import 'features/random/presentation/pages/random_chuck_norris_test.dart';
import 'features/random/presentation/widgets/categories_test.dart';
import 'features/random/presentation/widgets/category_test.dart';
import 'features/random/presentation/widgets/custom_button_test.dart';

void main() {
  setUpAll(() {
    nock.defaultBase = 'https://api.chucknorris.io';
    nock.init();
  });

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    initDependecies();
    await initFeaturesDependecies();
    nock.cleanAll();
  });

  group('core tests', () {
    injectionContainerTest();
    serverExceptionTest();
    failureTest();
    networkInfoTest();
    usecaseTest();
  });

  group('Random feature tests', () {
    // di
    group('di', () {
      dependecyInjectionTest();
    });

    // data
    group('data', () {
      group('datasource', () {
        randomDataSourceTest();
        randomDataSourceImplTest();
      });
      group('models', () {
        randomModelTest();
      });
      group('repository', () {
        randomRepositoryTest();
        randomRepositoryImplTest();
      });
    });
    // domain
    group('domain', () {
      group('entities', () {
        randomEntityTest();
      });
      group('usecases', () {
        getRandomUseCaseTest();
      });
    });
    // Presentation
    group('presentation', () {
      group('bloc', () {
        randomBlocTestWithPackage();
        randomBlocTest();
      });

      group('widgets', () {
        customButtonWidgetTest();
        categoryTesteWidget();
        categoriesWidgetTest();
        commonMainWidgetTest();
        randomChuckNorrisScreenWidgetTest();
      });
    });
  });
}
