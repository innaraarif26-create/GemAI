import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRtcService {
  RTCPeerConnection? _pc;
  MediaStream? _localStream;

  RTCPeerConnection get pc => _pc!;
  MediaStream get localStream => _localStream!;

  Future<void> init() async {
    final config = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _pc = await createPeerConnection(config);

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': false,
    });

    for (final track in _localStream!.getTracks()) {
      await _pc!.addTrack(track, _localStream!);
    }
  }

  Future<RTCSessionDescription> createOffer() async {
    final offer = await _pc!.createOffer();
    await _pc!.setLocalDescription(offer);
    return offer;
  }

  Future<RTCSessionDescription> createAnswer() async {
    final answer = await _pc!.createAnswer();
    await _pc!.setLocalDescription(answer);
    return answer;
  }

  Future<void> setRemoteDescription(Map<String, dynamic> sdpMap) async {
    final desc = RTCSessionDescription(
      sdpMap['sdp'] as String,
      sdpMap['type'] as String,
    );
    await _pc!.setRemoteDescription(desc);
  }

  Future<void> addRemoteIceCandidate(Map<String, dynamic> candMap) async {
    final candidate = RTCIceCandidate(
      candMap['candidate'] as String,
      candMap['sdpMid'] as String?,
      (candMap['sdpMLineIndex'] as num?)?.toInt(),
    );
    await _pc!.addCandidate(candidate);
  }

  Future<void> dispose() async {
    try {
      await _localStream?.dispose();
    } catch (_) {}
    try {
      await _pc?.close();
    } catch (_) {}
    _localStream = null;
    _pc = null;
  }
}