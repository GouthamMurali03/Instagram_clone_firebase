import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../utils/global_variables.dart';

class ResponsiveLayout extends StatefulWidget {
  static const routeName = '/Responsive';
  final Widget MobileScreenLayout;
  final Widget WebScreenLayout;

  const ResponsiveLayout({
    Key? key,
    required this.WebScreenLayout,
    required this.MobileScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
// Here we are using provider to initially listen to the value of the user once in the home screen
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > WebScreenSize) {
          return widget.WebScreenLayout;
        }
        return widget.MobileScreenLayout;
      },
    );
  }
}
