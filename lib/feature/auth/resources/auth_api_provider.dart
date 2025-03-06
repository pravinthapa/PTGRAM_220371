import 'package:ptgram/common/core/api_provider.dart';
import 'package:ptgram/common/hive/auth_hive.dart';

class AuthApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  AuthApiProvider({required this.baseUrl, required this.apiProvider});

  Future<dynamic> login({required Map<String, String> body}) async {
    final uri = "$baseUrl/users/login";

    return await apiProvider.post(uri, body);
  }

  Future<dynamic> signUp({required Map<String, String> body}) async {
    final uri = "$baseUrl/users/register";

    return await apiProvider.post(uri, body);
  }

  Future<dynamic> getProfile({required token}) async {
    final uri = Uri.parse("$baseUrl/users/current");

    return await apiProvider.get(uri, tokens: token);
  }

  Future<dynamic> getAllUser({required token}) async {
    final uri = Uri.parse("$baseUrl/users/all");

    return await apiProvider.get(uri, tokens: token);
  }
}
