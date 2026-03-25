import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final String category;

  final String sellerId;
  final String sellerName;
  final String sellerPhotoUrl;

  final List<String> imageUrls;

  final DateTime createdAt;

  final int views;
  final int likes;
  final bool isActive;

  final String gemType;
  final String color;
  final String origin;
  final double weightCarat;
  final String cut;
  final String clarity;
  final String treatment;
  final bool certification;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.category,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhotoUrl,
    required this.imageUrls,
    required this.createdAt,
    required this.views,
    required this.likes,
    required this.isActive,
    required this.gemType,
    required this.color,
    required this.origin,
    required this.weightCarat,
    required this.cut,
    required this.clarity,
    required this.treatment,
    required this.certification,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "price": price,
    "location": location,
    "category": category,
    "sellerId": sellerId,
    "sellerName": sellerName,
    "sellerPhotoUrl": sellerPhotoUrl,
    "imageUrls": imageUrls,
    "createdAt": Timestamp.fromDate(createdAt),
    "views": views,
    "likes": likes,
    "isActive": isActive,
    "gemType": gemType,
    "color": color,
    "origin": origin,
    "weightCarat": weightCarat,
    "cut": cut,
    "clarity": clarity,
    "treatment": treatment,
    "certification": certification,
  };

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data();
    if (data == null) throw StateError("Product ${doc.id} is empty.");

    return ProductModel(
      id: doc.id,
      title: (data["title"] ?? "").toString(),
      description: (data["description"] ?? "").toString(),
      price: (data["price"] is num) ? (data["price"] as num).toDouble() : 0.0,
      location: (data["location"] ?? "").toString(),
      category: (data["category"] ?? "").toString(),
      sellerId: (data["sellerId"] ?? "").toString(),
      sellerName: (data["sellerName"] ?? "").toString(),
      sellerPhotoUrl: (data["sellerPhotoUrl"] ?? "").toString(),
      imageUrls: (data["imageUrls"] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          <String>[],
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ??
          DateTime.fromMillisecondsSinceEpoch(0),
      views: (data["views"] is num) ? (data["views"] as num).toInt() : 0,
      likes: (data["likes"] is num) ? (data["likes"] as num).toInt() : 0,
      isActive: (data["isActive"] as bool?) ?? true,
      gemType: (data["gemType"] ?? "").toString(),
      color: (data["color"] ?? "").toString(),
      origin: (data["origin"] ?? "").toString(),
      weightCarat:
      (data["weightCarat"] is num) ? (data["weightCarat"] as num).toDouble() : 0.0,
      cut: (data["cut"] ?? "").toString(),
      clarity: (data["clarity"] ?? "").toString(),
      treatment: (data["treatment"] ?? "").toString(),
      certification: (data["certification"] as bool?) ?? false,
    );
  }
}