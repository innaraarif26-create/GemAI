class GemDetailModel {
  final String name;
  final String image;
  final List<PriceInfo> prices;
  final List<QualityFactor> qualityFactors;
  final List<String> origins;
  final List<ImitationItem> imitations;
  final List<String> history;
  final List<String> care;
  final List<String> uses;
  final List<String> buyingTips;

  GemDetailModel({
    required this.name,
    required this.image,
    required this.prices,
    required this.qualityFactors,
    required this.origins,
    required this.imitations,
    required this.history,
    required this.care,
    required this.uses,
    required this.buyingTips,
  });

  factory GemDetailModel.fromJson(Map<String, dynamic> json) {
    return GemDetailModel(
      name: json["name"],
      image: json["image"],

      prices: (json["prices"] as List)
          .map((e) => PriceInfo.fromJson(e))
          .toList(),

      qualityFactors: (json["qualityFactors"] as List)
          .map((e) => QualityFactor.fromJson(e))
          .toList(),

      origins: List<String>.from(json["origins"]),
      history: List<String>.from(json["history"]),
      care: List<String>.from(json["care"]),
      uses: List<String>.from(json["uses"]),
      buyingTips: List<String>.from(json["buyingTips"]),

      imitations: (json["imitations"] as List)
          .map((e) => ImitationItem.fromJson(e))
          .toList(),
    );
  }
}

class PriceInfo {
  final String quality;
  final String price;

  PriceInfo({required this.quality, required this.price});

  factory PriceInfo.fromJson(Map<String, dynamic> json) {
    return PriceInfo(
      quality: json["quality"],
      price: json["price"],
    );
  }
}

class QualityFactor {
  final String title;
  final String description;

  QualityFactor({required this.title, required this.description});

  factory QualityFactor.fromJson(Map<String, dynamic> json) {
    return QualityFactor(
      title: json["title"],
      description: json["description"],
    );
  }
}

class ImitationItem {
  final String img;
  final String title;
  final String desc;

  ImitationItem({
    required this.img,
    required this.title,
    required this.desc,
  });

  factory ImitationItem.fromJson(Map<String, dynamic> json) {
    return ImitationItem(
      img: json["img"],
      title: json["title"],
      desc: json["desc"],
    );
  }
}