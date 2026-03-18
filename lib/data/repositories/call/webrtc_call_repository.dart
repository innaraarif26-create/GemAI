import 'package:cloud_firestore/cloud_firestore.dart';

class WebRtcCallRepo {
  WebRtcCallRepo(this._db);
  final FirebaseFirestore _db;

  Future<String> createCall({
    required String callerId,
    required String calleeId,
    required String productId,
    required Map<String, dynamic> offer,
  }) async {
    final ref = _db.collection('calls').doc();

    await ref.set({
      'callerId': callerId,
      'calleeId': calleeId,
      'participants': [callerId, calleeId],
      'productId': productId,
      'status': 'ringing',
      'createdAt': FieldValue.serverTimestamp(),
      'offer': offer,
      'answer': null,
    });

    return ref.id;
  }

  Future<void> setAnswer({
    required String callId,
    required Map<String, dynamic> answer,
  }) async {
    await _db.collection('calls').doc(callId).update({
      'answer': answer,
      'status': 'accepted',
    });
  }

  Future<void> updateStatus(String callId, String status) async {
    await _db.collection('calls').doc(callId).update({'status': status});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> callDocStream(String callId) {
    return _db.collection('calls').doc(callId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> incomingCallsStream(String myUid) {
    return _db
        .collection('calls')
        .where('calleeId', isEqualTo: myUid)
        .where('status', isEqualTo: 'ringing')
        .snapshots();
  }

  CollectionReference<Map<String, dynamic>> signalsRef(String callId) {
    return _db.collection('calls').doc(callId).collection('signals');
  }

  Future<void> addIceCandidate({
    required String callId,
    required String fromUid,
    required Map<String, dynamic> candidate,
  }) async {
    await signalsRef(callId).add({
      'from': fromUid,
      'candidate': candidate,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> signalsStream(String callId) {
    return signalsRef(callId)
        .orderBy('createdAt', descending: false)
        .snapshots();
  }
}