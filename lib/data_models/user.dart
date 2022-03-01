import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  final String email;
  final String username;
  final String password;
  final String uid;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const OurUser(
      {required this.email,
      required this.username,
      required this.password,
      required this.uid,
      required this.bio,
      required this.photoUrl,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'username': username,
        'uid': uid,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  static OurUser fromSnapData(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return OurUser(
        email: snapshot['email'],
        username: snapshot['username'],
        password: snapshot['password'],
        uid: snapshot['uid'],
        bio: snapshot['bio'],
        photoUrl: snapshot['photoUrl'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
