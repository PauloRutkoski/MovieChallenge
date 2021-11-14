import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class ServiceUtils {
  static const String _token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOWMzYmU1ZmNhZTIwY2UyMDFlZDM2OTQyYzI5N2JmMyIsInN1YiI6IjYxOGZlOGFkNjNlNmZiMDA2MzczYTQyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7SAp4BoCRffNKC322JJE7ltmXBp_Cw9Z6CDoKATQIUQ";

  static const String _apiPath = "https://api.themoviedb.org/3";

  static const String genres = "/genre";
  static const String movies = "/movie";
  static const String search = "/search";

  static Map<String, String> headers = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json;charset=utf-8',
  };

  static Future<ConnectivityResult> testConnection() async {
    return await Connectivity().checkConnectivity();
  }

  static Future<bool> isConnected() async {
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }

  static Uri getApiUri(String path) {
    String uri = _apiPath + path;
    return Uri.parse(uri);
  }

  static Future<http.Response?> doGet(Uri uri) async {
    http.Response? response;
    if (await ServiceUtils.isConnected()) {
      response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(minutes: 1));
    }
    return response;
  }
}
