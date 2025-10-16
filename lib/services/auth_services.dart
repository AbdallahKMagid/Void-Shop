import 'package:shoppy/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final client = Supabase.instance.client;

  static Future logIn({required String password, required String email}) async {
    try {
      final authResponse = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      final id = authResponse.user?.id;
      final userEmail = authResponse.user?.email;
      if (id == null || userEmail == null) {
        return null;
      }
      return AuthModel(id: id, email: email);
    } on AuthException catch (e) {
      print("Auth Error (LogIn) : ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected Error (Login): $e");
      return null;
    }
  }

  static Future signUp({
    required String password,
    required String email,
  }) async {
    try {
      final authResponse = await client.auth.signUp(
        password: password,
        email: email,
      );
      final id = authResponse.user?.id;
      final userEmail = authResponse.user?.email;
      if (id == null || userEmail == null) {
        return null;
      }
      return AuthModel(id: id, email: email);
    } on AuthException catch (e) {
      print("Auth Error (SignUp) : ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected Error (SignUp): $e");
      return null;
    }
  }

  static Future signOut() async {
    try {
      await client.auth.signOut();
    } on AuthException catch (e) {
      print("Auth Error (SignOut) : ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected Error (SignOut): $e");
      return null;
    }
  }

  String? getCurrentUser(){
    final session=client.auth.currentSession;
    final user=session?.user;
    return user?.email;
  }
}
