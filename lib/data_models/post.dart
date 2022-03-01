import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String username;
  final String profImage;
  final String photoUrl;
  final String description;
  final String postId;
  final postedTime;
  final List likes;

  Post(
      {required this.uid,
      required this.username,
      required this.profImage,
      required this.photoUrl,
      required this.description,
      required this.postedTime,
      required this.postId,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'Username': username,
        'postId': postId,
        'ProfileImage': profImage,
        'PhotoUrl': photoUrl,
        'Description': description,
        'Posted Time': postedTime,
        'Likes': []
      };

  static Post fromSnapData(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        username: snapshot['Username'],
        uid: snapshot['uid'],
        photoUrl: snapshot['PhotoUrl'],
        profImage: snapshot['ProfileImage'],
        description: snapshot['Description'],
        postedTime: snapshot['Posted Time'],
        postId: snapshot['postId'],
        likes: snapshot['Likes']);
  }
}
