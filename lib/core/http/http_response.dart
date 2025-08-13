class HttpResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;

  HttpResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  });
}
