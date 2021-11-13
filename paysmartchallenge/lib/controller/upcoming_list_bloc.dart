import 'dart:async';

import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  int page = 1;
  final _movieService = MovieService();
  List<Movie> list = [];

  final _state = BehaviorSubject<StateEnum>.seeded(StateEnum.idle);

  Stream get stateStream => _state.stream;
  void setState(StateEnum state) => _state.sink.add(state);

  Future<void> refreshList() async {
    setState(StateEnum.loading);
    List<Movie> movies = await _movieService.findUpcoming(page);
    list.addAll(movies);
    setState(StateEnum.idle);
  }

  dispose() {
    _state.close();
  }
}
