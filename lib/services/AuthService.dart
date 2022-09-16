import 'package:chatroom/Utils/Singleton.dart';
import 'package:chatroom/services/UserService.dart';
import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  AuthService._();
  static final AuthService _instance = AuthService._();

 static AuthService get instace => _instance;
  User? get user => _auth.currentUser;

  factory AuthService() {
    return _instance;
  }

  final UserService _userService = UserService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginWithGoogle() async {
    final UserCredential userCredential =
        await _auth.signInWithProvider(GoogleAuthProvider());
    final User? user = userCredential.user;

    if (user != null &&
        (userCredential.additionalUserInfo?.isNewUser ?? false)) {
      await _userService.createUserFromCredential(userCredential);
    }
  }
}
