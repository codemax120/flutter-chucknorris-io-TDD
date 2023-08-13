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
import 'features/random/data/datasources/random_datasource_impl_test.dart';
import 'features/random/data/datasources/random_datasource_test.dart';
import 'features/random/di/dependecy_injection_test.dart';

void main() {
  setUpAll(() {
    nock.defaultBase = 'https://api.chucknorris.io';
    nock.init();
  });

  setUp(() async {
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
    dependecyInjectionTest();
    randomDataSourceTest();
    randomDataSourceImplTest();
  });
}
