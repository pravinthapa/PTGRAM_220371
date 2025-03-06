class Env {
  final String baseUrl;

  Env({required this.baseUrl});
}

class EnvValue {
  static final Env development = Env(
    baseUrl: "http://192.168.1.82:8000/api",
  );
}
