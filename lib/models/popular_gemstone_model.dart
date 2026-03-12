class GemDetailModel {
  final String name;

  /// thumb for home list (small image)
  final String thumbImage;

  /// detail image for detail screen (large image)
  final String detailImage;

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
    required this.thumbImage,
    required this.detailImage,
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
      name: (json["name"] ?? "") as String,
      thumbImage: (json["thumbImage"] ?? "") as String,
      detailImage: (json["detailImage"] ?? "") as String,

      prices: ((json["prices"] ?? []) as List)
          .map((e) => PriceInfo.fromJson(Map<String, dynamic>.from(e)))
          .toList(),

      qualityFactors: ((json["qualityFactors"] ?? []) as List)
          .map((e) => QualityFactor.fromJson(Map<String, dynamic>.from(e)))
          .toList(),

      origins: List<String>.from(json["origins"] ?? const []),
      history: List<String>.from(json["history"] ?? const []),
      care: List<String>.from(json["care"] ?? const []),
      uses: List<String>.from(json["uses"] ?? const []),
      buyingTips: List<String>.from(json["buyingTips"] ?? const []),

      imitations: ((json["imitations"] ?? []) as List)
          .map((e) => ImitationItem.fromJson(Map<String, dynamic>.from(e)))
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
      quality: (json["quality"] ?? "") as String,
      price: (json["price"] ?? "") as String,
    );
  }
}

class QualityFactor {
  final String title;
  final String description;

  QualityFactor({required this.title, required this.description});

  factory QualityFactor.fromJson(Map<String, dynamic> json) {
    return QualityFactor(
      title: (json["title"] ?? "") as String,
      description: (json["description"] ?? "") as String,
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
      img: (json["img"] ?? "") as String,
      title: (json["title"] ?? "") as String,
      desc: (json["desc"] ?? "") as String,
    );
  }
}