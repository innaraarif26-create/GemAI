import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistRepository {
  WishlistRepository._();
  static final WishlistRepository instance = WishlistRepository._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  DocumentReference<Map<String, dynamic>> _wishDoc(String uid, String productId) {
    return _db.collection('Users').doc(uid).collection('Wishlist').doc(productId);
  }

  Stream<bool> isWishlistedStream(String productId) {
    final uid = _uid;
    if (uid == null) return Stream.value(false);
    return _wishDoc(uid, productId).snapshots().map((doc) => doc.exists);
  }

  Future<void> add(String productId) async {
    final uid = _uid;
    if (uid == null) throw 'User not logged in';
    await _wishDoc(uid, productId).set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> remove(String productId) async {
    final uid = _uid;
    if (uid == null) throw 'User not logged in';
    await _wishDoc(uid, productId).delete();
  }

  Future<void> toggle(String productId, {required bool currentlyWishlisted}) async {
    if (currentlyWishlisted) {
      await remove(productId);
    } else {
      await add(productId);
    }
  }

  /// realtime count for appbar badge
  Stream<int> wishlistCountStream() {
    return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
      if (user == null) return Stream.value(0);

      return _db
          .collection('Users')
          .doc(user.uid)
          .collection('Wishlist')
          .snapshots()
          .map((snap) => snap.size);
    });
  }
}