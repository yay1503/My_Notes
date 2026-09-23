import "package:my_notes/services/auth/auth_user.dart"; 
import "package:my_notes/services/auth/auth_provider.dart";
import "package:my_notes/services/auth/auth_exceptions.dart";

import "package:firebase_auth/firebase_auth.dart" show FirebaseAuth, User;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({required String email, required String password}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  AuthUser? get currentUser {
    final user =  FirebaseAuth.instance.currentUser;
    if(user != null){
      return AuthUser.FromFirebase(user);
    }
    else{
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

}
