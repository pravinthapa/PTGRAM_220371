import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ptgram/common/core/custom_expection.dart';
import 'package:ptgram/common/core/dio_client.dart';

class ApiProvider {
  final String baseUrl;

  ApiProvider({
    required this.baseUrl,
  });
  late Dio _dio;
  Future<Map<String, dynamic>> post(
    String url,
    dynamic body, {
    String? userId,
    String token = '',
    bool isRefreshRequest = false,
    Map<String, String> header = const {},
  }) async {
    dynamic responseJson;
    final DioClient _dioClient = DioClient(baseUrl: baseUrl, userId: userId);

    try {
      final Map<String, String> _requestHeader = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        ...header,
      };

      if (token.isNotEmpty) {
        _requestHeader['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await _dioClient.post(
        Uri.parse(url),
        data: body,
        options: Options(headers: _requestHeader),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      debugPrint(e.toString());
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  //normal post request - which does not required access to (unauthorized post req)
  // Future<dynamic> post(
  //     String uri, {
  //       // ignore: type_annotate_public_apis
  //       data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       ProgressCallback? onSendProgress,
  //       ProgressCallback? onReceiveProgress,
  //     }) async {
  //   try {
  //     final response = await _dio.post(
  //       uri,
  //       data: data,
  //       queryParameters: queryParameters,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       options: options ?? Options(headers: {"requiresToken": false}),
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return response.data;
  //   } on SocketException catch (e) {
  //     throw SocketException(e.toString());
  //   } on FormatException catch (_) {
  //     throw const FormatException("Unable to process the data");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  Future<dynamic> patch(
    String url,
    dynamic body, {
    String? userId,
    String token = '',
    bool isRefreshRequest = false,
  }) async {
    final DioClient _dioClient = DioClient(baseUrl: baseUrl, userId: userId);

    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await _dioClient.patch(
        Uri.parse(url),
        data: body,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body, {
    required String? userId,
    String token = '',
  }) async {
    final DioClient _dioClient = DioClient(baseUrl: baseUrl, userId: userId);

    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      // if (token.isNotEmpty) {
      //   tokenHandler(accessToken: token);
      //   header['Authorization'] = 'Bearer $token';
      // }
      final dynamic response = await _dioClient.put(
        Uri.parse(url),
        data: body,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> get(
    Uri url, {
    String? userId,
    String tokens = '',
    int timeOut = 30,
  }) async {
    final DioClient _dioClient = DioClient(baseUrl: baseUrl, userId: userId);

    dynamic responseJson;

    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };

      if (tokens.isNotEmpty) {
        header['Authorization'] = 'Bearer $tokens';
      }
      final dynamic response = await _dioClient.get(
        url,
        options: Options(
          headers: header,
        ),
      );

      responseJson = _response(response, url.toString(), cacheResult: true);
    } on DioException catch (e, s) {
      responseJson = await _handleErrorResponse(e);
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
    return responseJson;
  }

  Future<dynamic> delete(Uri url, {String token = '', dynamic body}) async {
    final DioClient _dioClient = DioClient(
      baseUrl: baseUrl,
    );
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*'
      };
      debugPrint('TOKEN $token');
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer $token';
      }
      final dynamic response = await _dioClient.delete(url,
          data: body, options: Options(headers: header));
      responseJson = await _response(response, url.toString());
      responseJson['status'] = response.statusCode;
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  _handleErrorResponse(DioException e) async {
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw NoInternetException("", 1000);
    } else {
      if (e.response != null) {
        return await _response(e.response!, "");
      } else {
        throw FetchDataException(
          'An error occurred while fetching data.',
          e.response?.statusCode,
        );
      }
    }
  }

  Future<Map<String, dynamic>> _response(Response response, String url,
      {bool cacheResult = false}) async {
    final Map<String, dynamic> res = response.data is Map
        ? response.data
        : (response.data is List)
            ? {"data": response.data}
            : {};

    final responseJson = <String, dynamic>{};
    responseJson['data'] = res;

    responseJson['statusCode'] = response.statusCode;
    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(
            getErrorMessage(res, 400), response.statusCode);
      case 401:
        throw ResourceNotFoundException(
            getErrorMessage(res, 422), response.statusCode);

      case 409:
        throw BadRequestException(
            getErrorMessage(res, 40), response.statusCode);
      case 422:
        responseJson['error'] = getErrorMessage(res, response.statusCode);
        throw BadRequestException(
            getErrorMessage(res, 422), response.statusCode);
      case 429:
        responseJson['error'] = getErrorMessage(res, response.statusCode);
        throw BadRequestException(
            "You've made too many requests. Please try again after a while.",
            response.statusCode);
      case 401:
      case 403:
        throw UnauthorisedException(
            getErrorMessage(res, 422), response.statusCode);
      case 500:
        throw InternalServerErrorException(
            getErrorMessage(res, 422), response.statusCode);

      default:
        throw NoInternetException(
            'Error occured while Communication with Server', 1000);
    }
  }

  String getErrorMessage(dynamic res, [int? statusCode]) {
    String message = "";
    try {
      debugPrint(res.toString());
      debugPrint("-------------------GET ERROR ------------------");

      if (res["data"] is Map) {
        if (res["data"]?["message"] is String &&
            (res["data"]?["message"] ?? "").toString().isNotEmpty) {
          message = res["data"]?["message"];
          return message;
        }
      }
      if (res["message"] is String) {
        message = res["message"];
        return message;
      }
      if (res["message"] is List) {
        final List<dynamic> messages = res['message'][0]["messages"];
        for (var element in messages) {
          message += (element as Map<String, dynamic>)['message'] + '\n';
        }
        return message;
      }
      if (res["data"] is String) {
        message = res["data"] ?? "";
      }
    } catch (e) {
      return message.isEmpty
          ? _getErroMessageAccordingtoStatusCode(statusCode)
          : message;
    }
    return message.isEmpty
        ? _getErroMessageAccordingtoStatusCode(statusCode)
        : message;
  }

  String _getErroMessageAccordingtoStatusCode(int? statusCode) {
    if (statusCode == 422) {
      return "Bad Request";
    } else if (statusCode == 422) {
      return "Resource Not Found";
    } else if (statusCode == 422) {
      return "Bad Request";
    } else if (statusCode == 401 || statusCode == 401 || statusCode == 401) {
      return "Unauthorized";
    } else if (statusCode == 500) {
      return "Internal Server Error";
    } else {
      return "Something went wrong";
    }
  }
}
