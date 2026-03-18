import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../data/repositories/call/webrtc_call_repository.dart';
import '../../../../services/Firebase/webrtc_service.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen({
    super.key,
    required this.repo,
    required this.webRtc,
    required this.callId,
    required this.myUid,
    required this.callerName,
  });

  final WebRtcCallRepo repo;
  final WebRtcService webRtc;
  final String callId;
  final String myUid;
  final String callerName;

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  StreamSubscription? _signalsSub;
  final Set<String> _seenSignalDocs = {};
  bool _accepted = false;

  Future<void> _accept() async {
    if (_accepted) return;
    _accepted = true;

    await widget.webRtc.init();

    widget.webRtc.pc.onIceCandidate = (c) {
      widget.repo.addIceCandidate(
        callId: widget.callId,
        fromUid: widget.myUid,
        candidate: {
          'candidate': c.candidate,
          'sdpMid': c.sdpMid,
          'sdpMLineIndex': c.sdpMLineIndex,
        },
      );
    };

    final doc = await widget.repo.callDocStream(widget.callId).first;
    final data = doc.data();
    if (data == null) return;

    final offer = data['offer'];
    if (offer == null) return;

    await widget.webRtc.setRemoteDescription(
      Map<String, dynamic>.from(offer as Map),
    );

    final answer = await widget.webRtc.createAnswer();
    await widget.repo.setAnswer(
      callId: widget.callId,
      answer: {'type': answer.type, 'sdp': answer.sdp},
    );

    _signalsSub = widget.repo.signalsStream(widget.callId).listen((snap) async {
      for (final d in snap.docs) {
        if (_seenSignalDocs.contains(d.id)) continue;
        _seenSignalDocs.add(d.id);

        final data = d.data();
        if ((data['from'] ?? '') == widget.myUid) continue;

        final cand = Map<String, dynamic>.from(data['candidate'] as Map);
        await widget.webRtc.addRemoteIceCandidate(cand);
      }
    });

    if (mounted) setState(() {});
  }

  Future<void> _reject() async {
    await widget.repo.updateStatus(widget.callId, 'rejected');
    if (mounted) Navigator.pop(context);
  }

  Future<void> _hangup() async {
    await widget.repo.updateStatus(widget.callId, 'ended');
    await widget.webRtc.dispose();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _signalsSub?.cancel();
    widget.webRtc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inCall = _accepted;

    return Scaffold(
      appBar: AppBar(title: Text(inCall ? 'In call' : 'Incoming call')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(inCall
                ? 'Connected with ${widget.callerName}'
                : 'Call from ${widget.callerName}'),
            const SizedBox(height: 16),
            if (!inCall) ...[
              ElevatedButton(onPressed: _accept, child: const Text('Accept')),
              const SizedBox(height: 8),
              OutlinedButton(onPressed: _reject, child: const Text('Reject')),
            ] else ...[
              ElevatedButton(onPressed: _hangup, child: const Text('Hang up')),
            ],
          ],
        ),
      ),
    );
  }
}