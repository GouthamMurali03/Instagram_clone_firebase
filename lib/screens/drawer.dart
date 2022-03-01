import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';
import '../screens/add_post.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          AppBar(
            title: const Text('Heyy User!'),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
          ),
          // When autoimplyleading is false, it does not show a back button
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed(FeedScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Add Post'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddPostScreen.routeName);
            },
          ),
          const ListTile(
              leading: Icon(Icons.favorite), title: Text('Activity')),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
