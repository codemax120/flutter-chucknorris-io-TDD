import 'package:chuck_norris_io/core/injection/injection_container.dart';
import 'package:chuck_norris_io/features/main/common_main.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAuthDependecies();
  await initDependencies();
  runApp(const MyApp());
}
