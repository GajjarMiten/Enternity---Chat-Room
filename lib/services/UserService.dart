import 'package:chatroom/models/User.dart' as UserModel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  static UserService get instance => _instance;

  factory UserService() {
    return _instance;
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserFromCredential(UserCredential userCredential) async {
    final User? user = userCredential.user;
    final DocumentReference userRef =
        _firestore.collection("new-users").doc(user!.uid);
    final DocumentSnapshot userSnapshot = await userRef.get();
    if (!userSnapshot.exists) {
      await userRef.set({
        "name": user.displayName ?? user.email!.split("@")[0],
        "email": user.email,
        "photo": user.photoURL,
        "createdAt": DateTime.now(),
      });
    }
  }

  Future<UserModel.User?> getUserById(String id) async {
    final DocumentReference userRef = _firestore.collection("users").doc(id);
    final DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      return UserModel.User.fromMap(userSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }
}
