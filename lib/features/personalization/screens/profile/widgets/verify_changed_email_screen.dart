import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemai/core/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../../widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyChangedEmailScreen extends StatefulWidget {
  final String newEmail;

  const VerifyChangedEmailScreen({
    super.key,
    required this.newEmail,
  });

  @override
  State<VerifyChangedEmailScreen> createState() => _VerifyChangedEmailScreenState();
}

class _VerifyChangedEmailScreenState extends State<VerifyChangedEmailScreen> {
  Timer? _verificationTimer;

  @override
  void initState() {
    super.initState();
    _startEmailVerificationCheck();
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    super.dispose();
  }

  void _startEmailVerificationCheck() {
    _verificationTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();

        // Show success message
        AppLoaders.successSnackBar(
          title: "Email Verified",
          message: "Your email has been successfully verified!",
        );

        // Navigate to home after a short delay
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => AuthenticationRepository().screenRedirect());
      }
    });
  }

  Future<void> _resendVerificationEmail() async {
    try {
      AppLoaders.successSnackBar(
        title: "Email Sent",
        message: "Verification email sent. Check your inbox.",
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: const Text("Verify Email"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Email Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.mail_solid,
                  size: 50,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 30),

              // Title
              Text(
                "Verify Your Email",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // New Email Display
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  widget.newEmail,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                "A verification link has been sent to your new email address. Please click the link in the email to verify your new email address.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Waiting message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Waiting for verification...",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _resendVerificationEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Resend Verification Email"),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}