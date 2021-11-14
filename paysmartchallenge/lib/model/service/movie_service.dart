import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/genre_service.dart';
import 'package:paysmartchallenge/model/service/service_utils.dart';

class MovieService {
  final _genreService = GenreService();

  Future<List<Movie>> findUpcoming(int page) async {
    String path = ServiceUtils.movies + "/upcoming?page=$page";
    Uri uri = ServiceUtils.getApiUri(path);

    http.Response? response = await ServiceUtils.doGet(uri);
    if (response == null || response.statusCode != 200) {
      return [];
    }
    Map<String, dynamic> body = json.decode(response.body);
    return await _decode(body['results']);
  }

  Future<List<Movie>> _decode(List<dynamic> maps) async {
    List<Movie> movies = [];
    List<Genre> genres = await _genreService.findAll();
    for (Map<String, dynamic> map in maps) {
      List<Genre> movieGenres =
          getGenres(genres, List<int>.from(map['genre_ids']));
      map['genres'] = movieGenres;
      movies.add(Movie.fromJson(map));
    }
    return movies;
  }

  List<Genre> getGenres(List<Genre> genres, List<int> genreIds) {
    List<Genre> movieGenres = [];
    for (Genre genre in genres) {
      if (genreIds.length == movieGenres.length) {
        break;
      }
      if (genreIds.contains(genre.id)) {
        movieGenres.add(genre);
      }
    }
    return movieGenres;
  }
}
