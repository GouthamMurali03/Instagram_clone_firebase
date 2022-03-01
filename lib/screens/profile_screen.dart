import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import '../widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .get();
      var postSnapshot = await FirebaseFirestore.instance
          .collection('Posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      userData = userSnapshot.data()!;
      postLen = postSnapshot.docs.length;
      followers = userSnapshot.data()!['followers'].length;
      following = userSnapshot.data()!['following'].length;
      isFollowing = userSnapshot
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                userData['username'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(userData['photoUrl']),
                              radius: 26,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    createColumn(postLen, 'Posts'),
                                    createColumn(followers, 'Followers'),
                                    createColumn(following, 'Following')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            function: () {
                                              AuthMethods().signOut();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen(),
                                                ),
                                              );
                                            },
                                            backgroundColor: Colors.black,
                                            borderColor: Colors.grey,
                                            textColor: primaryColor,
                                            text: 'Sign Out')
                                        : isFollowing
                                            ? FollowButton(
                                                function: () async {
                                                  FirestoreMethods()
                                                      .followMethod(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          widget.uid);
// Here, we are using future builder, so followers list will not update directly. We have to refresh the screen.
// So we are increasing the count and changing follow/unfollow button manually.
// To change this automatically, use Streambuilder
                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                                backgroundColor: Colors.black,
                                                borderColor: Colors.grey,
                                                textColor: primaryColor,
                                                text: 'Unfollow')
                                            : FollowButton(
                                                function: () async {
                                                  FirestoreMethods()
                                                      .followMethod(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          widget.uid);
                                                  setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                                backgroundColor: Colors.black,
                                                borderColor: Colors.blue,
                                                textColor: primaryColor,
                                                text: 'Follow')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userData['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userData['bio'],
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Divider(),
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Posts')
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as dynamic).docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 1.5,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                                  (snapshot.data! as dynamic).docs[index];

                              return Container(
                                child: Image(
                                  image: NetworkImage(snap['PhotoUrl']),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Column createColumn(
    int num,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$num',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5, right: 5),
          child: Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
