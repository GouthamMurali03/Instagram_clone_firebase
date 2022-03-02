import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/new_mobile_screen.dart';
import 'package:instagram_clone_flutter/screens/Dummy_screen.dart';
import 'package:instagram_clone_flutter/screens/add_post.dart';
import 'package:instagram_clone_flutter/screens/comments_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import './responsive/mobile_screen_layout.dart';
import './responsive/web_screen_layout.dart';
import './responsive/responsive.dart';
import './utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Here we are waiting for flutter widgets to be initialized, and then we initialize the app via firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBJwnzVYgfnxC6U0jBfwNEkbYbzhU46RT0',
          appId: '1:417893473495:web:05c3561b7d74e1e80d6492',
          messagingSenderId: '417893473495',
          projectId: 'instagram-clone-a3582',
          storageBucket: 'instagram-clone-a3582.appspot.com'),
// Storagebucket is also a mandatory field and it should be added
    );
// For apps to run in web, firebase options must be enabled.
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const ResponsiveLayout(
        //   WebScreenLayout: WebScreenLayout(),
        //   MobileScreenLayout: MobileSCreenLayout(),

        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          ResponsiveLayout.routeName: (ctx) => const ResponsiveLayout(
              WebScreenLayout: WebScreenLayout(),
              MobileScreenLayout: MobileSCreenLayout()),
          DummyScreen.routeName: (ctx) => const DummyScreen(),
          AddPostScreen.routeName: (ctx) => const AddPostScreen(),
          FeedScreen.routeName: (ctx) => const FeedScreen(),
          SearchScreen.routeName: (ctx) => const SearchScreen(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    WebScreenLayout: WebScreenLayout(),
                    MobileScreenLayout: NewMobileScreen());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
