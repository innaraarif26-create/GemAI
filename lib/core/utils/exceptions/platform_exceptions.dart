class AppPlatformException implements Exception {
  final String message;

  AppPlatformException(this.message);

  factory AppPlatformException.fromCode(String code) {
    switch (code) {
      default:
        return AppPlatformException('Platform error occurred.');
    }
  }
}