class GemDetailModel
{
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
}

class PriceInfo {
  final String quality;
  final String price;

  PriceInfo({required this.quality, required this.price});
}

class QualityFactor {
  final String title;
  final String description;

  QualityFactor({required this.title, required this.description});
}

class ImitationItem {
  final String img;
  final String title;
  final String desc;

  ImitationItem({required this.img, required this.title, required this.desc});
}