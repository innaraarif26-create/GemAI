import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../data/repositories/call/webrtc_call_repository.dart';
import '../../../../services/Firebase/webrtc_service.dart';
import '../../../../widgets/appbar/appbar.dart';

class OutgoingCallScreen extends StatefulWidget {
  const OutgoingCallScreen({
    super.key,
    required this.repo,
    required this.webRtc,
    required this.callerId,
    required this.calleeId,
    required this.productId,
    required this.calleeName,
  });

  final WebRtcCallRepo repo;
  final WebRtcService webRtc;
  final String callerId;
  final String calleeId;
  final String productId;
  final String calleeName;

  @override
  State<OutgoingCallScreen> createState() => _OutgoingCallScreenState();
}

class _OutgoingCallScreenState extends State<OutgoingCallScreen> {
  String? _callId;
  StreamSubscription? _callSub;
  StreamSubscription? _signalsSub;
  final Set<String> _seenSignalDocs = {};

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await widget.webRtc.init();

    widget.webRtc.pc.onIceCandidate = (c) {
      if (_callId == null) return;

      widget.repo.addIceCandidate(
        callId: _callId!,
        fromUid: widget.callerId,
        candidate: {
          'candidate': c.candidate,
          'sdpMid': c.sdpMid,
          'sdpMLineIndex': c.sdpMLineIndex,
        },
      );
    };

    final offer = await widget.webRtc.createOffer();

    final callId = await widget.repo.createCall(
      callerId: widget.callerId,
      calleeId: widget.calleeId,
      productId: widget.productId,
      offer: {'type': offer.type, 'sdp': offer.sdp},
    );

    setState(() => _callId = callId);

    _callSub = widget.repo.callDocStream(callId).listen((doc) async {
      final data = doc.data();
      if (data == null) return;

      final status = (data['status'] ?? '').toString();
      if (status == 'rejected' || status == 'ended') {
        if (mounted) Navigator.pop(context);
        return;
      }

      final answer = data['answer'];
      if (answer != null) {
        try {
          await widget.webRtc.setRemoteDescription(
            Map<String, dynamic>.from(answer as Map),
          );
        } catch (_) {}
      }
    });

    _signalsSub = widget.repo.signalsStream(callId).listen((snap) async {
      for (final d in snap.docs) {
        if (_seenSignalDocs.contains(d.id)) continue;
        _seenSignalDocs.add(d.id);

        final data = d.data();
        if ((data['from'] ?? '') == widget.callerId) continue;

        final cand = Map<String, dynamic>.from(data['candidate'] as Map);
        await widget.webRtc.addRemoteIceCandidate(cand);
      }
    });
  }

  Future<void> _hangup() async {
    final id = _callId;
    if (id != null) {
      await widget.repo.updateStatus(id, 'ended');
    }
    await widget.webRtc.dispose();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _callSub?.cancel();
    _signalsSub?.cancel();
    widget.webRtc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: Text('Calling ${widget.calleeName}'),showBackArrow: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_callId == null ? 'Starting...' : 'Ringing...'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hangup,
              child: const Text('Hang up'),
            ),
          ],
        ),
      ),
    );
  }
}