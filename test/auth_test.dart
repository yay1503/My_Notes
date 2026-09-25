import "package:my_notes/services/auth/auth_provider.dart";
import "package:my_notes/services/auth/auth_user.dart";
import "package:test/test.dart";

void main () {}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  bool get isIntialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email, 
    required String password,
    }) {
    
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> intialize() {
    // TODO: implement intialize
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> logIn({
    required String email, 
    required String password,
    }) {
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