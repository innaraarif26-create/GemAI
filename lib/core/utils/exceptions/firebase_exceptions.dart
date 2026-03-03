class AppFirebaseException implements Exception
{
  final String message;

  AppFirebaseException(this.message);

  factory AppFirebaseException.fromCode(String code)
  {
    switch (code) {
      case 'permission-denied':
        return AppFirebaseException('You do not have permission.');
      case 'not-found':
        return AppFirebaseException('Data not found.');
      default:
        return AppFirebaseException('Firebase error occurred.');
    }
  }
}