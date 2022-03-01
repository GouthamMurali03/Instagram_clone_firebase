import 'dart:typed_data';
import 'package:instagram_clone_flutter/utils/utils.dart';

import '../data_models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addPost(
    Uint8List file,
    String description,
    String uid,
    String profImage,
    String username,
  ) async {
    String res = 'Some error occured';
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('Posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          uid: uid,
          username: username,
          description: description,
          likes: [],
          photoUrl: photoUrl,
          postedTime: DateTime.now(),
          profImage: profImage,
          postId: postId);

      _firestore.collection('Posts').doc(postId).set(post.toJson());

      res = 'Success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('Posts').doc(postId).update({
          'Likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('Posts').doc(postId).update({
          'Likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> addComments(String postId, String userName, String profImage,
      String comment, String uid) async {
    String res = 'Some error occured';
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commentId)
            .set({
          'profilePic': profImage,
          'userName': userName,
          'uid': uid,
          'commentId': commentId,
          'comment': comment,
          'datePublished': DateTime.now(),
        });
        res = 'Posted successfully';
      } else {
        res = 'Text is empty';
      }
    } catch (e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }

  Future<void> followMethod(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('Users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('Users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('Users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('Users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
