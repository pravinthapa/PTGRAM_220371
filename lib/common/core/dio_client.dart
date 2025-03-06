import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio = Dio();
  final String baseUrl;
  final String? userId;
  DioClient({
    required this.baseUrl,
    this.userId,
  }) {
    _dio
      ..httpClientAdapter
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        InterceptorsWrapper(
          onResponse: (res, handler) async {
            // if (res.headers.map['set-cookie'] != null) {
            //   String value = res.headers.map['set-cookie']!.first;

            //   if (value.contains("refresh=")) {
            //     final temp = value.split("refresh=")[1];
            //     final refreshToken = temp.split(";")[0];
            //     if (refreshToken.isNotEmpty) {
            //       // await AuthHive.setRefreshToken(refreshtoken: refreshToken);
            //     }
            //   }
            // }
            return handler.next(res);
          },
        ),
      );

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: true,
          requestBody: true));
    }
  }

  Future<Response> get(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.getUri(
        uri,
        options: options,
        // cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      //   rethrow;
      // }
      rethrow;
    }
  }

  Future<dynamic> post(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (data is Map) {
      payload:
      Map<String, dynamic>.from(data);
    }

    try {
      final response = await _dio.postUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<dynamic> put(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.putUri(
        uri,
        data: data,
        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<dynamic> patch(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patchUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     // default:
      //     //   rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<Response> delete(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.deleteUri(uri,
          // queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          data: data);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     // default:
      //     //   rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }
}


// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:metro_appointment_admin/common/hive/auth_hive.dart';
// import 'package:metro_appointment_admin/common/http/custom_exception.dart';
// import 'package:metro_appointment_admin/common/http/jwt_utils.dart';
// import 'package:metro_appointment_admin/common/navigation/navigation_service.dart';
// import 'package:metro_appointment_admin/common/route/route.dart';
// import 'package:metro_appointment_admin/common/utils/custom_toast.dart';
// import 'package:metro_appointment_admin/feature/auth/resource/auth_repository.dart';

// class DioClient {
//   final Dio _dio = Dio();
//   final String baseUrl;
//   final String? userId;
//   DioClient({
//     required this.baseUrl,
//     this.userId,
//   }) {
//     _dio
//       ..httpClientAdapter
//       ..options.responseType = ResponseType.json
//       ..interceptors
//           .add(InterceptorsWrapper(onRequest: (options, handler) async {
//         final token = await AuthHive.getAccessToken();
//         if (token != null && token.isNotEmpty) {
//           bool value =await tokenHandler(accessToken: token);
//           if(!value){
            
//           }
//           options.headers['Authorization'] = 'Bearer $token';
//         }

//         return handler.next(options); //
//       }));

//     if (kDebugMode) {
//       _dio.interceptors.add(LogInterceptor(
//           responseBody: true,
//           error: true,
//           requestHeader: true,
//           responseHeader: false,
//           request: true,
//           requestBody: true));
//     }
//   }

//   Future<Response> get(
//     Uri uri, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.getUri(
//         uri,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on SocketException catch (e) {
//       throw SocketException(e.toString());
//     } on FormatException catch (_) {
//       throw const FormatException("Unable to process the data");
//     } catch (error) {
//       // if (error is DioError) {
//       //   switch (error.response?.statusCode) {
//       //     // case 401:
//       //     //   return await requestRetrier(
//       //     //     baseUrl: baseUrl,
//       //     //     response: error.response!,
//       //     //     userId: userId,
//       //     //   );
//       //     default:
//       //       rethrow;
//       //   }
//       // } else {
//       //   rethrow;
//       // }
//       rethrow;
//     }
//   }

//   Future<dynamic> post(
//     Uri uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     if (data is Map) {
//       payload:
//       Map<String, dynamic>.from(data);
//     }

//     try {
//       final response = await _dio.postUri(
//         uri,
//         data: data,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on FormatException catch (_) {
//       throw const FormatException("Unable to process the data");
//     } catch (error) {
//       // if (error is DioError) {
//       //   switch (error.response?.statusCode) {
//       //     // case 401:
//       //     //   return await requestRetrier(
//       //     //     baseUrl: baseUrl,
//       //     //     response: error.response!,
//       //     //     userId: userId,
//       //     //   );
//       //     default:
//       //       rethrow;
//       //   }
//       // } else {
//       // }
//       rethrow;
//     }
//   }

//   Future<dynamic> put(
//     Uri uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.putUri(
//         uri,
//         data: data,
//         // queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on FormatException catch (_) {
//       throw const FormatException("Unable to process the data");
//     } catch (error) {
//       // if (error is DioError) {
//       //   switch (error.response?.statusCode) {
//       //     // case 401:
//       //     //   return await requestRetrier(
//       //     //     baseUrl: baseUrl,
//       //     //     response: error.response!,
//       //     //     userId: userId,
//       //     //   );
//       //     default:
//       //       rethrow;
//       //   }
//       // } else {
//       // }
//       rethrow;
//     }
//   }

//   Future<dynamic> patch(
//     Uri uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.patchUri(
//         uri,
//         data: data,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response;
//     } on FormatException catch (_) {
//       throw const FormatException("Unable to process the data");
//     } catch (error) {
//       // if (error is DioError) {
//       //   switch (error.response?.statusCode) {
//       //     // case 401:
//       //     //   return await requestRetrier(
//       //     //     baseUrl: baseUrl,
//       //     //     response: error.response!,
//       //     //     userId: userId,
//       //     //   );
//       //     // default:
//       //     //   rethrow;
//       //   }
//       // } else {
//       // }
//       rethrow;
//     }
//   }

//   Future<Response> delete(
//     Uri uri, {
//     Map<String, dynamic>? queryParameters,
//     Map<String, dynamic>? data,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       final response = await _dio.deleteUri(uri,
//           // queryParameters: queryParameters,
//           options: options,
//           cancelToken: cancelToken,
//           data: data);
//       return response;
//     } on SocketException catch (e) {
//       throw SocketException(e.toString());
//     } on FormatException catch (_) {
//       throw const FormatException("Unable to process the data");
//     } catch (error) {
//       // if (error is DioError) {
//       //   switch (error.response?.statusCode) {
//       //     // case 401:
//       //     //   return await requestRetrier(
//       //     //     baseUrl: baseUrl,
//       //     //     response: error.response!,
//       //     //     userId: userId,
//       //     //   );
//       //     // default:
//       //     //   rethrow;
//       //   }
//       // } else {
//       // }
//       rethrow;
//     }
//   }
// }

// Future<bool> tokenHandler({required String accessToken}) async {
//   try {
//     if (accessToken == "") {
//       // throw CustomException("user session timeout  Login again");

//       return false;
//     }
//     final payloadAccessToken = JwtUtils.parseJwtPayLoad(accessToken);

//     DateTime currentDateTime = DateTime.now();

//     debugPrint("current date ${currentDateTime.toIso8601String()}");

//     DateTime accessTokenExpDateTime =
//         DateTime.fromMillisecondsSinceEpoch(payloadAccessToken['exp'] * 1000);

//     debugPrint("access token ${accessTokenExpDateTime.toIso8601String()}");

//     if (currentDateTime.isAfter(accessTokenExpDateTime)) {
//       return false;
//     } else {
//       return true;
//     }
//   } catch (e) {
//     await RepositoryProvider.of<AuthRepository>(NavigationService.context)
//         .logout();

//     NavigationService.pushNamedAndRemoveUntil(routeName: Routes.dashboardPage);

//     CustomToast.error(message: "Sesson Timeout, Login Again");

//     debugPrint(e.toString());
//     rethrow;
//   }
// }