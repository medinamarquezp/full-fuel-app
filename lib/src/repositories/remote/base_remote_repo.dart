import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseRemoteRepo {
  final apiURL = DotEnv().env['API_URL'];
  final apiVersion = DotEnv().env['API_VERSION'];
  final authorization = DotEnv().env['API_AUTH_KEY'];

  Map<String, String> headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authorization,
    };
  }
}
