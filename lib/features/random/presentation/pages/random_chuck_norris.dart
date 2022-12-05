import 'package:flutter/material.dart';

class RandomChuckNorrisScreen extends StatelessWidget {
  static const routeName = '/';

  const RandomChuckNorrisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Procedo a disenar'),
      ),
    );
  }
}
