
class AppFirebaseAuthException implements Exception {
  final String message;

  AppFirebaseAuthException(this.message);

  factory AppFirebaseAuthException.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return AppFirebaseAuthException(
            'Email is already registered.');
      case 'invalid-email':
        return AppFirebaseAuthException(
            'Invalid email address.');
      case 'weak-password':
        return AppFirebaseAuthException(
            'Password is too weak.');
      case 'user-not-found':
        return AppFirebaseAuthException(
            'User not found.');
      case 'wrong-password':
        return AppFirebaseAuthException(
            'Incorrect password.');
      default:
        return AppFirebaseAuthException(
            'Authentication error occurred.');
    }
  }

  @override
  String toString() => message;
}