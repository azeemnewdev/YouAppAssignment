class HttpResponse<T> {
  final T? data;
  final int statusCode;
  final String? message;
  final bool isSuccess;

  HttpResponse({required this.statusCode, this.data, this.message})
    : isSuccess = statusCode >= 200 && statusCode < 300;

  @override
  String toString() =>
      'HttpResponse(statusCode: $statusCode, isSuccess: $isSuccess, message: $message, data: $data)';
}
