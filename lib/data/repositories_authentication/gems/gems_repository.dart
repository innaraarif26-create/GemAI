import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gemai/core/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';
import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../models/popular_gemstone_model.dart';

class GemsRepository extends GetxController {

  /// Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get All Popular Gems
  Future<List<GemDetailModel>> fetchGems() async {
    try {
      final snapshot = await _db.collection("popular_gems").get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        final model = data["model"];
        return GemDetailModel.fromJson(model);
      }).toList();

    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch(e) {
      throw AppPlatformException(e.code).message;
    } catch(e){
      throw "Something went wrong. Please try again";
    }
  }


}