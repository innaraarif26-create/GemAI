import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistRepository {
  WishlistRepository._();
  static final WishlistRepository instance = WishlistRepository._();

  final _db = FirebaseFirestore.instance;

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw 'User not logged in';
    return user.uid;
  }

  DocumentReference<Map<String, dynamic>> _wishDoc(String productId) {
    return _db.collection('Users').doc(_uid).collection('Wishlist').doc(productId);
  }

  /// realtime: true if exists in wishlist
  Stream<bool> isWishlistedStream(String productId) {
    return _wishDoc(productId).snapshots().map((doc) => doc.exists);
  }

  Future<void> add(String productId) async {
    await _wishDoc(productId).set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> remove(String productId) async {
    await _wishDoc(productId).delete();
  }

  Future<void> toggle(String productId, {required bool currentlyWishlisted}) async {
    if (currentlyWishlisted) {
      await remove(productId);
    } else {
      await add(productId);
    }
  }
}