import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prabin/common/core/api_provider.dart';
import 'package:prabin/feature/auth/resources/auth_repo.dart';


class RealsApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  RealsApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getReals() async {
    final uri = Uri.parse("$baseUrl/post");

    return await apiProvider.get(
      uri,
      tokens: authRepository.accessToken,
    );
  }

  Future<dynamic> postContent({required FormData body}) async {
    final uri = "$baseUrl/post";

    return await apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> like({required String id}) async {
    final uri =
        Uri.parse("$baseUrl/post/like/?id=$id"); 

    return await apiProvider.post(
      uri.toString(), 
      {}, 
      token: authRepository.accessToken,
    );
  }
}
