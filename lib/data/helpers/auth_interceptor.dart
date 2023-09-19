import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {
  const AuthInterceptor(this.token);

  final String token;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers.addAll({'Authorization': 'Bearer $token'});
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
