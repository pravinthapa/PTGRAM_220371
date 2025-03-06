import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prabin/common/app/env.dart';
import 'package:prabin/common/core/api_provider.dart';
import 'package:prabin/common/core/response.dart';
import 'package:prabin/feature/auth/resources/auth_repo.dart';
import 'package:prabin/feature/home/model/reals_model.dart';
import 'package:prabin/feature/home/repository/reals_api_provider.dart';


class RealsRepository {
  final Env env;
  final ApiProvider apiProvider;
  late RealsApiProvider realsApiProvider;
  final AuthRepository authRepository;
  RealsRepository(
      {required this.apiProvider,
      required this.env,
      required this.authRepository}) {
    realsApiProvider = RealsApiProvider(
        baseUrl: env.baseUrl,
        apiProvider: apiProvider,
        authRepository: authRepository);
  }

  Future<DataResponse<List<Post>>> getReals() async {
    List<Post> temp = [];

    try {
      final res = await realsApiProvider.getReals();
      final data = res['data'];

      if (data is List) {
        temp = data.map((e) => Post.fromJson(e)).toList();
      } else if (data is Map<String, dynamic>) {
        // If 'data' is a Map, try extracting the list from a known key
        final list = data['data'] ?? [];
        if (list is List) {
          temp = list.map((e) => Post.fromJson(e)).toList();
        }
      }

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint('Error in getReals: $e');
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> postContent({
    required String description,
    required File? file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "description": description,
      });

      if (file != null) {
        MultipartFile photoMultipartFile = await MultipartFile.fromFile(
          file.path,
          filename: 'file.jpg',
        );

        formData.files.add(MapEntry("file", photoMultipartFile));
      }

      await realsApiProvider.postContent(body: formData);

      return DataResponse.success(true);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> sendLike({
    required String id,
  }) async {
    try {
      await realsApiProvider.like(id: id);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }
}
