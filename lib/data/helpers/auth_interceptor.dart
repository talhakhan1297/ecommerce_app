import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  String? token;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers.addAll({
      if (token != null) 'Authorization': 'Bearer $token',
      'content-type': 'application/json',
    });

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
