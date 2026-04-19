class SearchResult {
  final String title;
  final String image;
  final String category;
  final bool isNetworkImage;
  final dynamic data;

  const SearchResult({
    required this.title,
    required this.image,
    required this.category,
    this.isNetworkImage = false,
    this.data,
  });
}
