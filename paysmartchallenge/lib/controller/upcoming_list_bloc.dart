import 'dart:async';

import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/genre_service.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  int page = 1;
  final _movieService = MovieService();
  final _genreService = GenreService();
  List<Genre> _genres = [];
  List<Movie> list = [];

  final _state = BehaviorSubject<StateEnum>.seeded(StateEnum.idle);

  Stream get stateStream => _state.stream;
  void setState(StateEnum state) => _state.sink.add(state);

  Future<void> init() async {
    setState(StateEnum.loading);
    _genres = await _genreService.findAll();
    await refreshList();
  }

  Future<void> refreshList() async {
    setState(StateEnum.loading);
    List<Movie> movies = await _movieService.findUpcoming(page);
    defineGenres(movies);
    list.addAll(movies);
    setState(StateEnum.idle);
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
}
