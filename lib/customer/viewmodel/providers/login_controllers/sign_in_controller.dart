import 'package:flutter/material.dart';
import 'package:pipi/customer/viewmodel/providers/user_provider.dart';
import 'package:pipi/services/auth_service.dart';
import 'package:pipi/services/data_service.dart';
import 'package:pipi/services/hive_service.dart';
import 'package:pipi/services/log_service.dart';

class SignInController extends ChangeNotifier {
  TextEditingController phoneNumberOrGmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool scroll = false;
  bool isLoading = false;
  String isUser = "none";

  updateScroll(value) {
    scroll = value;
    notifyListeners();
  }

  updateIsLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  checkUser(BuildContext context, UserProvider userProvider) async {
    await FirestoreService.getUser().then((value) {
      for (var element in value) {
        Log.w("phoneNumber: " + element.phoneNumber.toString());
        Log.w("password: " + element.password.toString());
        if (element.phoneNumber == phoneNumberOrGmailController.text &&
            element.password == passwordController.text) {
          isUser = "yes";
          FirestoreService.deleteUser(userProvider.user.id!);
          AuthService.deleteUser(context);
          userProvider.setUser(element);
          HiveService.saveUser(element);
          notifyListeners();
          break;
        }
      }
    });
    if (isUser == "yes") {
      Navigator.pop(context);
      return;
    }
    isUser = "no";
    notifyListeners();
  }
}
