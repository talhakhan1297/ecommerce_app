import 'dart:developer';

import 'package:ecommerce_app/data/helpers/helpers.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ExpiredTokenRetryPolicy implements RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    if (reason is UnauthorizedException) {
      log('Retrying request...');

      // Refresh Token API call and updated stored token

      return true;
    }

    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    return false;
  }
}
