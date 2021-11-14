import 'dart:async';

import 'package:logger/logger.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:paysmartchallenge/model/service/service_utils.dart';
import 'package:paysmartchallenge/view/utils/notify.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  final _movieService = MovieService();
  int page = 1;
  List<Movie> list = [];
  String query = "";

  final _state = BehaviorSubject<StateEnum>.seeded(StateEnum.idle);

  Stream<StateEnum> get stateStream => _state.stream;
  void setState(StateEnum state) => _state.sink.add(state);

  Future<void> init() async {
    setState(StateEnum.loading);
    list = [];
    page = 1;
    bool connected = await ServiceUtils.isConnected();
    if (connected) {
      await refreshList();
    } else {
      setState(StateEnum.offline);
    }
  }

  Future<void> refreshList() async {
    try {
      List<Movie> movies = [];
      if (query.trim().isEmpty) {
        movies = await _movieService.findUpcoming(page);
      } else {
        movies = await _movieService.findByQuery(query, page);
      }
      list.addAll(movies);
      setState(StateEnum.idle);
    } catch (e) {
      handleException(e);
    }
  }

  void handleException(Object e) {
    if (e is TimeoutException) {
      Notify.error("Timeout on search");
      setState(StateEnum.offline);
    } else {
      setState(StateEnum.idle);
    }
    Logger().e(e.toString());
  }

  dispose() {
    _state.close();
  }
}
