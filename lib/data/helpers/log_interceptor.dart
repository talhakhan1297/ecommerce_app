import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class LogInterceptor extends InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    log('\n----- Request -----');
    log('\n');
    log('${data.method}: ${data.url}');
    log('Headers: ${data.headers}');
    log('Params: ${data.params}');
    log('Body: ${data.body}');
    log('\n');
    log('-------------------');
    log('\n');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log('\n----- Response -----');
    log('\n');
    log('Status Code: ${data.statusCode}');
    log('Response Body: ${data.body}');
    log('\n');
    log('--------------------');
    log('\n');
    return data;
  }
}
