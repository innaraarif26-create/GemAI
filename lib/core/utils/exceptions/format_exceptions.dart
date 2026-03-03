class AppFormatException implements Exception
{
  final String message;

  const AppFormatException(
      [this.message = "Invalid data format."]);
}