import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';

import 'package:ecommerce_app/data/helpers/exceptions.dart';

class ErrorInterceptor extends InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    switch (data.statusCode) {
      case 200:
      case 201:
        return data;
      case 400:
      case 422:
        throw BadRequestException(
          (jsonDecode(data.body ?? '{}') as Map<String, dynamic>)['message']
              as String?,
        );
      case 401:
      case 403:
        throw UnauthorizedException(
          (jsonDecode(data.body ?? '{}') as Map<String, dynamic>)['message']
              .toString(),
        );
      case 404:
        throw NotFoundException(
          (jsonDecode(data.body ?? '{}') as Map<String, dynamic>)['message']
              .toString(),
        );
      case 500:
      default:
        throw const FetchDataException(
          'Something went wrong, please try again later.',
        );
    }
  }
}
