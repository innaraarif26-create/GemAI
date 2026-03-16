import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  /// null while restoring session / logged out
  final Rxn<User> user = Rxn<User>();

  StreamSubscription<User?>? _sub;

  @override
  void onInit() {
    super.onInit();

    // This will fire on startup and whenever login/logout happens
    _sub = _auth.authStateChanges().listen((u) {
      user.value = u;
    });
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}