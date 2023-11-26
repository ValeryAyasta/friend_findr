class Result {
  final bool success;
  final dynamic data;
  final String message;

  const Result(
      {required this.success, required this.data, required this.message});
}