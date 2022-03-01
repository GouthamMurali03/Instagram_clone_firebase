import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_clone_flutter/screens/Dummy_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DummyScreen()));
        },
        // onPressed: () {
        //   Navigator.of(context).pushNamedAndRemoveUntil(
        //       DummyScreen.routeName, (Route<dynamic> route) => false);
        // },
        child: const Center(
          child: Text('Move to dummy Screen'),
        ),
      ),
    );
  }
}
