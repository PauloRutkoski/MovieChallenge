import 'package:http/http.dart' as http;

class ServiceUtils {
  static const String _token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOWMzYmU1ZmNhZTIwY2UyMDFlZDM2OTQyYzI5N2JmMyIsInN1YiI6IjYxOGZlOGFkNjNlNmZiMDA2MzczYTQyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7SAp4BoCRffNKC322JJE7ltmXBp_Cw9Z6CDoKATQIUQ";

  static const String _apiPath = "https://api.themoviedb.org/3";
  static const String _imagePath = "https://image.tmdb.org/t/p/";

  static const String genres = "/genre";
  static const String movies = "/movie";

  static Map<String, String> headers = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json;charset=utf-8',
  };

  static Uri getApiUri(String path) {
    String uri = _apiPath + path;
    return Uri.parse(uri);
  }

  static Future<http.Response> doGet(Uri uri) async {
    http.Response response = await http.get(uri, headers: headers);
    return response;
  }
}
