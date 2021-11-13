import 'dart:async';

import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/genre_service.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  int page = 1;
  final _movieService = MovieService();
  final _genreService = GenreService();
  List<Genre> _genres = [];

  final _list = BehaviorSubject<List<Movie>>.seeded([]);

  Stream<List<Movie>> get listStream => _list.stream;

  List<Movie> get list => _list.value;

  void setList(List<Movie> list) {
    _list.sink.add(list);
  }

  Future<void> init() async {
    _genres = await _genreService.findAll();
  }

  Future<void> refreshList() async {
    List<Movie> movies = await _movieService.findUpcoming(page);
    defineGenres(movies);
    list.addAll(movies);
    setList(list);
  }

  void defineGenres(List<Movie> movies) {
    for (Movie movie in movies) {
      movie.genres = [];
      for (Genre genre in _genres) {
        if (movie.genreIds.length == movie.genres!.length) {
          break;
        }
        if (movie.genreIds.contains(genre.id)) {
          movie.genres!.add(genre);
        }
      }
    }
  }

  void dispose() {
    _list.close();
  }
}
