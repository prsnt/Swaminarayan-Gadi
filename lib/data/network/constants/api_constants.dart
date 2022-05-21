class WSKeys {

  WSKeys({
    required this.baseUrl, required this.apiKey
  });

  factory WSKeys.local() {
    return WSKeys(
      baseUrl: 'local-url',
        apiKey: WSParameters.APIKey
    );
  }

  factory WSKeys.staging() {
    return WSKeys(
      baseUrl: 'staging-url',
        apiKey: WSParameters.APIKey
    );
  }

  factory WSKeys.production() {
    return WSKeys(
      baseUrl: 'base_url',
        apiKey: WSParameters.APIKey
    );
  }

  final String baseUrl;
  final String apiKey;
}


class WSParameters {
  WSParameters._();
  static const APIKey = 'test-key';

  static const accept = 'accept';
  static const xUserToken = 'X-User-Token';
  static const xApiKey = 'X-Api-Key';
  static const xUserLang = 'X-User-Lang';
  static const contentType = 'Content-Type';
}

bool isProfileLoaded = false;