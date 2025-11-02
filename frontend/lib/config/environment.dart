class Environment {
  Environment._();

  // Point to your ASP.NET backend
  static const String apiBaseUrl = 'http://localhost:5043';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 20);
}
