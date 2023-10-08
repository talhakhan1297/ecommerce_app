import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

import 'package:ecommerce_app/data/helpers/api_config.dart';
import 'package:ecommerce_app/data/helpers/auth_interceptor.dart';
import 'package:ecommerce_app/data/helpers/error_interceptor.dart';
import 'package:ecommerce_app/data/helpers/exceptions.dart';
import 'package:ecommerce_app/data/helpers/log_interceptor.dart';
import 'package:ecommerce_app/data/helpers/retry_policy.dart';

/// API Client to interact with any REST API
class APIClient {
  APIClient({
    InterceptedClient? client,
    InterceptorContract? authInterceptor,
    InterceptorContract? errorInterceptor,
    InterceptorContract? logInterceptor,
    RetryPolicy? retryPolicy,
  }) : _client = client ??
            InterceptedClient.build(
              interceptors: [
                // Pass AuthInterceptor through getIt and set token on login and
                // signup.
                authInterceptor ?? AuthInterceptor(),
                errorInterceptor ?? ErrorInterceptor(),
                logInterceptor ?? LogInterceptor(),
              ],
              retryPolicy: retryPolicy ?? ExpiredTokenRetryPolicy(),
            );

  final InterceptedClient _client;

  /// Used to initiate a [get] request
  ///
  /// The [handle] is end point that will be attached to the [baseUrl]
  /// which either can be provided as a whole using the [APIConfig]
  /// setting or can be overidden as it is given as an option parameter
  /// in the function.
  ///
  /// Same thing applies for the [header] parameter
  Future<dynamic> get({
    required String handle,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
  }) async {
    // final url to which call will be made
    final url = (baseUrl ?? APIConfig.baseUrl) + handle;

    // uri to be passed to request
    final uri = Uri.parse(url);

    // final timeout to be used with request
    final responseTimeOut = timeOut ?? APIConfig.responseTimeOut;

    try {
      final response =
          await _client.get(uri, headers: header).timeout(responseTimeOut);

      return jsonDecode(response.body);
    } on SocketException {
      throw const FetchDataException();
    } on TimeoutException {
      throw const TimeOutExceptionC();
    }
  }

  /// Used to initiate a [post] request
  ///
  /// Use the [body] parameter to send the json data to the service
  ///
  /// The [handle] is end point that will be attached to the [baseUrl]
  /// which either can be provided as a whole using the [APIConfig]
  /// setting or can be overidden as it is given as an option parameter
  /// in the function.
  ///
  /// Same thing applies for the [header] parameter
  Future<dynamic> post({
    required String handle,
    dynamic body,
    String? baseUrl,
    Map<String, String>? header,
    Duration? timeOut,
  }) async {
    // final url to which call will be made
    final url = (baseUrl ?? APIConfig.baseUrl) + handle;

    // uri to be passed to request
    final uri = Uri.parse(url);

    // final timeout to be used with request
    final responseTimeOut = timeOut ?? APIConfig.responseTimeOut;

    try {
      final response = await _client
          .post(
            uri,
            headers: header,
            body: jsonEncode(body),
          )
          .timeout(responseTimeOut);

      return jsonDecode(response.body);
    } on SocketException {
      throw const FetchDataException();
    } on TimeoutException {
      throw const TimeOutExceptionC();
    }
  }
}
