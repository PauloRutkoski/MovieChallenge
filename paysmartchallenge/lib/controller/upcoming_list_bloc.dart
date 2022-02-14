import 'dart:async';

import 'package:logger/logger.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:paysmartchallenge/model/service/service_utils.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingListBloc {
  late MovieService _movieService;
  int page = 1;
  List<Movie> list = [];
  String query = "";

  final _state = BehaviorSubject<StateEnum>.seeded(StateEnum.idle);

  UpcomingListBloc([MovieService? service]) {
    page = 1;
    list = [];
    query = "";
    _movieService = service ?? MovieService();
  }

  Stream<StateEnum> get stateStream => _state.stream;
  void setState(StateEnum state) => _state.sink.add(state);
  StateEnum get state => _state.value;

  Future<void> init() async {
    bool connected = await ServiceUtils.isConnected();
    await initList(connected);
  }

  Future<void> initList(bool isConnected) async {
    setState(StateEnum.loading);
    list = [];
    page = 1;
    await refreshList(isConnected);
  }

  Future<void> refreshList(bool isConnected) async {
    if (!isConnected) {
      setState(StateEnum.offline);
      return;
    }
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
      //Notify.error("Timeout on search");
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
