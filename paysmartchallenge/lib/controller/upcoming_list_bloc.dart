import 'dart:async';

import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  final _movieService = MovieService();
  int page = 1;
  List<Movie> list = [];

  final _state = BehaviorSubject<StateEnum>.seeded(StateEnum.idle);

  Stream get stateStream => _state.stream;
  void setState(StateEnum state) => _state.sink.add(state);

  Future<void> init() async {
    setState(StateEnum.loading);
    await refreshList();
  }

  Future<void> refreshList() async {
    List<Movie> movies = await _movieService.findUpcoming(page);
    list.addAll(movies);
    setState(StateEnum.idle);
  }

  dispose() {
    _state.close();
  }
}
