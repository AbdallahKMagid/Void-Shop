import 'package:flutter/cupertino.dart';
import 'package:shoppy/models/auth_model.dart';
import 'package:shoppy/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  AuthModel? usersModel;
  bool hasAcc = false;

  Future signUp({required String email, required String password}) async {
    try {
      usersModel = await AuthService.signUp(password: password, email: email);
      hasAcc = usersModel != null ? true : false;
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
    return usersModel != null;
  }

  Future logIn({required String email, required String password}) async {
    try {
      usersModel = await AuthService.logIn(password: password, email: email);
      hasAcc = usersModel != null ? true : false;
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
    return usersModel != null;
  }

  Future signOut() async {
    await AuthService.signOut();
    notifyListeners();
  }
String? getUserEmail(){
    return AuthService().getCurrentUser();
}
}
