import 'package:http/http.dart' as http;

class HttpUtil {
  static void get(String url, Function callback, Function errorCallback) async {
    try {
      http.Response resp = await http.get(url);
      if (callback != null) {
        callback(resp.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response resp = await http.post(url, body: params);
      if (callback != null) {
        callback(resp.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }
}
