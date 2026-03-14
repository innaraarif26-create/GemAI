import 'package:get/get.dart';
import '../../../data/repositories/product/product_repository.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final repo = ProductRepository.instance;

  final search = "".obs;
  final category = "".obs;

  final sortBy = "createdAt".obs; // createdAt | views | price
  final descending = true.obs;

  Stream<List<ProductModel>> popularStream() => repo.watchPopularMostViewed(limit: 4);

  Stream<List<ProductModel>> allStream() => repo.watchAll(
    search: search.value,
    category: category.value.isEmpty ? null : category.value,
    sortBy: sortBy.value,
    descending: descending.value,
  );
}