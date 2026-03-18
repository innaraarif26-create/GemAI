import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/call/webrtc_call_repository.dart';
import '../../../../services/Firebase/webrtc_service.dart';
import 'incoming_call_screen.dart';

class CallListener extends StatefulWidget {
  const CallListener({
    super.key,
    required this.myUid,
    required this.child,
    required this.getCallerName,
  });

  final String myUid;
  final Widget child;

  /// You decide how to get display name from /Users
  final Future<String> Function(String callerId) getCallerName;

  @override
  State<CallListener> createState() => _CallListenerState();
}

class _CallListenerState extends State<CallListener> {
  StreamSubscription? _sub;
  bool _handling = false;
  final _repo = WebRtcCallRepo(FirebaseFirestore.instance);

  @override
  void initState() {
    super.initState();

    _sub = _repo.incomingCallsStream(widget.myUid).listen((snap) async {
      if (!mounted) return;
      if (_handling) return;
      if (snap.docs.isEmpty) return;

      final doc = snap.docs.first;
      final callId = doc.id;
      final data = doc.data();
      final callerId = (data['callerId'] ?? '').toString();

      _handling = true;

      final callerName = await widget.getCallerName(callerId);

      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IncomingCallScreen(
            repo: _repo,
            webRtc: WebRtcService(),
            callId: callId,
            myUid: widget.myUid,
            callerName: callerName,
          ),
        ),
      );

      _handling = false;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}