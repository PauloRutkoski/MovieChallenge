import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/service_utils.dart';

class MovieService {
  Future<List<Movie>> findUpcoming(int page) async {
    String path = ServiceUtils.movies + "/upcoming";
    Uri uri = ServiceUtils.getApiUri(path);

    http.Response response = await ServiceUtils.doGet(uri);
    if (response.statusCode != 200) {
      return [];
    }
    Map<String, dynamic> body = json.decode(response.body);
    return _decode(body['results']);
  }

  _decode(List<dynamic> maps) {
    List<Movie> movies = [];
    for (Map<String, dynamic> map in maps) {
      movies.add(Movie.fromJson(map));
    }
    return movies;
  }
}
