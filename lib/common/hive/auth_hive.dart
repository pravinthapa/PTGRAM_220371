import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ptgram/feature/auth/model/user_model.dart';

class AuthHive {
  // static final AuthHive _hiveServices = AuthHive._internal();

  // factory AuthHive() {
  //   return _hiveServices;
  // }

  // AuthHive._internal();

  static const userresource = "user_resource";
  static const accessToken = "accessToken";
  static const refreshToken = "refreshToken";
  static const userData = "userData";
  static const rememberMe = "remember_me";
  static const language = "language";
  String fingerdebugPrint = "fingerdebugPrint";

  static init() async {
    await Hive.initFlutter();
  }

  static Future<void> setAccessToken({required String accesstoken}) async {
    final box = await Hive.openBox(userresource);
    await box.put(accessToken, accesstoken);
    await box.close();
  }

  static Future<String?> getAccessToken() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(accessToken);
      // await box.close();
      if (data == null) {
        return null;
      }
      return data.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> removeAccessToken() async {
    final box = await Hive.openBox(userresource);
    await box.delete(accessToken);
    await box.close();
  }

  static Future<void> setRefreshToken({required String refreshtoken}) async {
    final box = await Hive.openBox(userresource);
    await box.put(refreshToken, refreshtoken);
    await box.close();
  }

  static Future<String?> getRefreshToken() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(refreshToken);
      await box.close();
      if (data == null) {
        return null;
      }
      return data.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> removeRefreshToken() async {
    final box = await Hive.openBox(userresource);
    await box.delete(refreshToken);
    await box.close();
  }

  static Future<void> setUser({required UserModel user}) async {
    final box = await Hive.openBox(userresource);
    await box.put(userData, jsonEncode(user.toMap()));
    await box.close();
  }

  static Future<UserModel?> getUser() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(userData);
      await box.close();
      if (data == null) {
        return null;
      }
      UserModel user = UserModel.fromMap(jsonDecode(data ?? ""));
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> removeUser() async {
    final box = await Hive.openBox(userresource);
    await box.delete(userData);
    await box.close();
  }

  static Future<void> setRemember(String user) async {
    final box = await Hive.openBox(userresource);
    await box.put(rememberMe, user);
    await box.close();
  }

  static Future<String?> getRemember() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(rememberMe);
      await box.close();
      if (data == null) {
        return data;
      }

      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> removeRemember() async {
    final box = await Hive.openBox(userresource);
    await box.delete(rememberMe);
    await box.close();
  }

  // static Future<void> setLanguage(String user) async {
  //   final box = await Hive.openBox(userresource);
  //   await box.put(language, user);
  //   await box.close();
  // }
  Future<void> setLanguage(String user) async {
    final box = await Hive.openBox(userresource);
    await box.put(language, user);
    await box.close();
  }

  static Future<String?> getLanguage() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(language);
      await box.close();
      if (data == null) {
        return data;
      }

      return data;
    } catch (e) {
      print(e.toString());
      return "en";
    }
  }

  Future<void> setFingerPrintEnable() async {
    final box = await Hive.openBox(userresource);
    await box.put(fingerdebugPrint, "enable");
    // await box.close();
  }

  Future<bool> isFingerPrintEnable() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(fingerdebugPrint);
      await box.close();
      if (data == null) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
