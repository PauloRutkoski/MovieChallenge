import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/service/service_utils.dart';

class GenreService {
  Future<List<Genre>> findAll() async {
    String path = ServiceUtils.genres + "/movie/list";
    Uri uri = ServiceUtils.getApiUri(path);

    http.Response response = await ServiceUtils.doGet(uri);
    if (response.statusCode != 200) {
      return [];
    }
    Map<String, dynamic> body = json.decode(response.body);
    return _decode(body["genres"]);
  }

  _decode(List<dynamic> maps) {
    List<Genre> genres = [];
    for (Map<String, dynamic> map in maps) {
      genres.add(Genre.fromJson(map));
    }
    return genres;
  }
}
