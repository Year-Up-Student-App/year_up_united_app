class AppConfig {
  static const bool isProduction = false;
  static const bool enableQRScanner = false; // flip off for simulator, on for device

  static const String baseUrl = isProduction
      ? 'https://api.yearupunited.com/api' // production url here (cloud database)
      : 'http://localhost:8080/api'; // local url here (local database)
}