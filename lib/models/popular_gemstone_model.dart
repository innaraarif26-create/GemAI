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

  factory GemDetailModel.fromMap(Map<String, dynamic> data) {
    return GemDetailModel(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      prices: (data['prices'] as List<dynamic>)
          .map((e) => PriceInfo.fromMap(e))
          .toList(),
      qualityFactors: (data['qualityFactors'] as List<dynamic>)
          .map((e) => QualityFactor.fromMap(e))
          .toList(),
      origins: List<String>.from(data['origins'] ?? []),
      imitations: (data['imitations'] as List<dynamic>)
          .map((e) => ImitationItem.fromMap(e))
          .toList(),
      history: List<String>.from(data['history'] ?? []),
      care: List<String>.from(data['care'] ?? []),
      uses: List<String>.from(data['uses'] ?? []),
      buyingTips: List<String>.from(data['buyingTips'] ?? []),
    );
  }
}

class PriceInfo {
  final String quality;
  final String price;

  PriceInfo({required this.quality, required this.price});

  factory PriceInfo.fromMap(Map<String, dynamic> data) {
    return PriceInfo(
      quality: data['quality'] ?? '',
      price: data['price'] ?? '',
    );
  }
}

class QualityFactor {
  final String title;
  final String description;

  QualityFactor({required this.title, required this.description});

  factory QualityFactor.fromMap(Map<String, dynamic> data) {
    return QualityFactor(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}

class ImitationItem {
  final String img;
  final String title;
  final String desc;

  ImitationItem({required this.img, required this.title, required this.desc});

  factory ImitationItem.fromMap(Map<String, dynamic> data) {
    return ImitationItem(
      img: data['img'] ?? '',
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
    );
  }
}