final class AppException implements Exception {
  AppException({
    this.title,
    this.detail,
  });

  factory AppException.error(String title) => AppException(title: title);

  final String? title;
  final String? detail;

  @override
  String toString() => '$title, $detail';
}
