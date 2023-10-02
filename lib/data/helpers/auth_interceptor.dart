import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  String? token;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (token != null) {
      data.headers.addAll({'Authorization': 'Bearer $token'});
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
