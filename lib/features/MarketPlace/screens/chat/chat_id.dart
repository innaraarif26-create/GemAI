String buildChatId({
  required String buyerId,
  required String sellerId,
  required String productId,
}) {
  final a = buyerId.compareTo(sellerId) <= 0 ? buyerId : sellerId;
  final b = buyerId.compareTo(sellerId) <= 0 ? sellerId : buyerId;
  return '${a}_${b}_$productId';
}