import 'package:flutter/material.dart';

import 'package:ptgram/common/app/env.dart';
import 'package:ptgram/common/core/api_provider.dart';
import 'package:ptgram/common/core/response.dart';
import 'package:ptgram/common/hive/auth_hive.dart';
import 'package:ptgram/feature/auth/model/user_all_model.dart';
import 'package:ptgram/feature/auth/model/user_model.dart';
import 'package:ptgram/feature/auth/resources/auth_api_provider.dart';

class AuthRepository {
  final Env env;
  final ApiProvider apiProvider;
  late AuthApiProvider authApiProvider;

  AuthRepository({
    required this.apiProvider,
    required this.env,
  }) {
    authApiProvider = AuthApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
    );
  }

  String _accessToken = '';

  String _refreshToken = "";

  String get accessToken => _accessToken;

  String get refreshToken => _refreshToken;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);

  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  final ValueNotifier<UserModel?> _user = ValueNotifier(null);

  ValueNotifier<UserModel?> get user => _user;
  final ValueNotifier<String> _userRole = ValueNotifier("");

  ValueNotifier<String> get userRole => _userRole;
  // String? get userId => user.value?.id;

  Future initial() async {
    await fetchAccessToken();
    // await fetchRefreshToken();
    _user.value = await AuthHive.getUser();
  }

  Future setAccessToken(String accessToken) async {
    try {
      await AuthHive.setAccessToken(accesstoken: accessToken);
      _isLoggedIn.value = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future setRefreshToken(String refreshToken) async {
  //   try {
  //     await AuthHive.setRefreshToken(refreshtoken: refreshToken);
  //     _isLoggedIn.value = true;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<String> fetchAccessToken() async {
    try {
      final accessToken = await AuthHive.getAccessToken();
      if (accessToken != null && accessToken != "") {
        _accessToken = accessToken;
        _isLoggedIn.value = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return accessToken;
  }

  // Future<String> fetchRefreshToken() async {
  //   try {
  //     final refreshToken = await AuthHive.getRefreshToken();
  //     if (refreshToken != null && refreshToken != "") {
  //       _refreshToken = refreshToken;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return refreshToken;
  // }

  Future<DataResponse<bool>> login(
      {required String email, required String password}) async {
    try {
      Map<String, String> body = {
        "email": email,
        "password": password,
      };

      final res = await authApiProvider.login(body: body);

      _accessToken = res['data']?['accessToken'] ?? "";
      _user.value = UserModel.fromMap(res['data']?['userData'] ?? {});

      await AuthHive.setUser(user: _user.value!);

      await setAccessToken(_accessToken);
      _isLoggedIn.value = true;
      return DataResponse.success(true);
    } catch (e) {
      _accessToken = '';
      _refreshToken = '';
      _isLoggedIn.value = false;
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, String> body = {
        "email": email,
        "password": password,
        "username": username,
      };

      final res = await authApiProvider.signUp(body: body);

      _isLoggedIn.value = true;

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<UserModel>> getUserProfile() async {
    try {
      final res = await authApiProvider.getProfile(token: _accessToken);

      UserModel temp = UserModel.fromMap(res['data']);

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  // Future<DataResponse<List<User>>> getAllUser() async {
  //   try {
  //     final res = await authApiProvider.getAllUser(token: _accessToken);

  //     // Ensure `res['data']` is a List
  //     if (res['data'] is List) {
  //       List<User> users = (res['data'] as List)
  //           .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
  //           .toList();

  //       return DataResponse.success(users);
  //     } else {
  //       return DataResponse.error("Invalid data format: Expected a list");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return DataResponse.error(e.toString());
  //   }
  // }

  Future<DataResponse<List<User>>> getAllUser() async {
    List<User> temp = [];

    try {
      final res = await authApiProvider.getAllUser(token: _accessToken);

      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => User.fromJson(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      return DataResponse.success(temp);
    }
  }
}
