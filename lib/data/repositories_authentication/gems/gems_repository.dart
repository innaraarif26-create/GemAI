import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../models/popular_gemstone_model.dart';

class GemsRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<GemDetailModel>> fetchGems() async {
    try {
      final snapshot = await _db.collection("popular_gems").orderBy("order", descending: false).get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        // top-level thumb image
        final String thumb = (data["image"] ?? "") as String;

        // model map contains detail image and all other fields
        final Map<String, dynamic> model =
        Map<String, dynamic>.from((data["model"] ?? {}) as Map);

        final String detail = (model["image"] ?? "") as String;

        // provide both fields to the model parser
        model["thumbImage"] = thumb;
        model["detailImage"] = detail;

        return GemDetailModel.fromJson(model);
      }).toList();
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}