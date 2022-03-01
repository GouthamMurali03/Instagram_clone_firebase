import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/responsive/responsive.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import '../utils/utils.dart';
import '../resources/auth_methods.dart';
import '../widgets/text_field_input.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/Signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

// Don't forget to dispose the controller

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // Here pickImage returns a dynamic and Uint8list can be assigned to a dynamic
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'Success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacementNamed(ResponsiveLayout.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              // Circle Avatar with image and option to add image
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.white,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                          backgroundColor: Colors.white,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),

              // TextFieldInput for username
              Expanded(
                child: TextFieldInput(
                    textEditingController: _userNameController,
                    hintText: 'Enter your Username',
                    keyboardType: TextInputType.text),
              ),
              const SizedBox(
                height: 24,
              ),
              // TextFieldInput for bio
              Expanded(
                child: TextFieldInput(
                    textEditingController: _bioController,
                    hintText: 'Enter a bio',
                    keyboardType: TextInputType.text),
              ),
              const SizedBox(
                height: 24,
              ),
              // TextInput for email
              Expanded(
                child: TextFieldInput(
                    textEditingController: _emailController,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.text,
                  isPass: true,
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // Login button
              InkWell(
                onTap: signUpUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Container(
                        child: const Text(
                          'Sign up',
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
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
              // Sign up button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text("Already have an account?"),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        child: const Text("Log in"),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
