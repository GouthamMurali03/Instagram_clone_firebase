import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  static const routeName = '/dummy';
  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Dummy'),
      ),
    );
  }
}
