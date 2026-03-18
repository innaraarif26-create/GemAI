import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'features/MarketPlace/screens/call/call_listener.dart';

class AppAfterLogin extends StatelessWidget {
  const AppAfterLogin({super.key, required this.myUid, required this.child});
  final String myUid;
  final Widget child;

  Future<String> _getCallerName(String callerId) async {
    final doc = await FirebaseFirestore.instance.collection('Users').doc(callerId).get();
    return (doc.data()?['fullName'] ?? 'Unknown').toString();
  }

  @override
  Widget build(BuildContext context) {
    return CallListener(
      myUid: myUid,
      getCallerName: _getCallerName,
      child: child,
    );
  }
}