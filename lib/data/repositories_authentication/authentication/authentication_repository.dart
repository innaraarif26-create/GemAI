import 'package:flutter/foundation.dart';
import 'package:gemai/features/auth/screens/signup/verify_email.dart';
import 'package:gemai/features/onboarding/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gemai/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/utils/exceptions/firebase_auth_exceptions.dart';
import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/format_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../features/auth/screens/login/login_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Functions to show Relevant Screen
  Future<void> screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null)
      {
        if(user.emailVerified)
          {
            Get.offAll(() => const NavigationMenu());
          }
        else
          {
            Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
          }
      }
    else
      {
        // Local Storage
        deviceStorage.writeIfNull("IsFirstTime", true);
        deviceStorage.read("IsFirstTime") != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(const OnboardingScreen());
      }
   }



  /* ---------------------- Email And Password sign in ------------------- */

    /// [EmailAuthentication] - signIn
  Future<UserCredential> loginWIthEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



   /// [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



   /// [EmailVerification] - Mail Verification
   Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
   }

   /// [ReAuthenticate] - ReAuthenticate User

   /// [EmailAuthentication] - Forget Password



  /* ---------------------- Federated identity and social sign-in ------------------- */

   /// [GoogleAuthentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {

      final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = account.authentication;

      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken,);

      return await _auth.signInWithCredential(credential);

    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;

    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;

    } on FormatException {
      throw const AppFormatException();

    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;

    } catch (e) {
      if (kDebugMode) print("Something went wrong: $e");
      return null;
    }
  }



   /// [FacebookAuthentication] - Facebook

  /* ---------------------- .end Federated identity & social sign-in ------------------- */

   /// [LogoutUser] - valid for any authentication.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch(e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
   /// Delete User - Remove user Auth and Firestore Account

}
