import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/responsive/new_mobile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import '../utils/colors.dart';
// Add svg dependency in main.dart file and add the above import. The url should have two flutter_svg in its name

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

// Don't forget to dispose the controller

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'Success') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NewMobileScreen(),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
// Here the flex with an empty container will take up all the space in the top leaving only optimum space for other widgets
            Flexible(
              child: Container(),
              flex: 1,
            ),
            // Svg Image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
// Add this asset in pubspec.yaml file too
              color: primaryColor,
              width: 128,
            ),
            // TextInput for email
            // TextFieldInput is the widget that you created for TextField
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              keyboardType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            // Login button
            InkWell(
              onTap: loginUser,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Container(
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 18),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          color: blueColor),
                    ),
            ),
            const SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            // Sign up button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SignUpScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Container(
                    child: const Text("Sign up"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      )),
    );
  }
}
