import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:paysmartchallenge/controller/upcoming_list_bloc.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/model/service/movie_service.dart';
import 'package:mockito/mockito.dart';
import 'package:paysmartchallenge/view/utils/state.dart';

import 'factory_fake_movies.dart';
import 'upcoming_list_bloc_test.mocks.dart';

@GenerateMocks([MovieService])
void main() {
  late UpcomingListBloc sut;
  late MockMovieService serviceMock;

  setUp(() {
    serviceMock = MockMovieService();
    sut = UpcomingListBloc(serviceMock);
  });

  test(
    "Assert Class init State",
    () {
      expect(sut.list, []);
      expect(sut.page, 1);
      expect(sut.query, "");
    },
  );

  List<Movie> getFakes() => <Movie>[
        FactoryFakeMovies.build(1),
        FactoryFakeMovies.build(2),
        FactoryFakeMovies.build(3),
      ];

  void findUpcomingMoviesEmptyList() async {
    when(serviceMock.findUpcoming(any)).thenAnswer((_) async => []);
  }

  void findUpcomingMoviesFullList() async {
    when(serviceMock.findUpcoming(any)).thenAnswer(
      (_) async => getFakes(),
    );
  }

  void findByQueryMoviesEmptyList() async {
    when(serviceMock.findByQuery(any, any)).thenAnswer((_) async => []);
  }

  void findByQueryMoviesFullList() async {
    when(serviceMock.findByQuery(any, any)).thenAnswer(
      (_) async => getFakes(),
    );
  }

  void findThrowException(Object e) {
    when(serviceMock.findUpcoming(any)).thenThrow(e);
  }

  group("Verify calling refresh list on init list", () {
    test(
      "With internet connection",
      () async {
        findUpcomingMoviesEmptyList();
        await sut.initList(true);
        verify(serviceMock.findUpcoming(any)).called(1);
        expect(sut.list, []);
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
      },
    );

    test(
      "Without internet connection",
      () async {
        findUpcomingMoviesEmptyList();
        await sut.initList(false);
        verifyNever(serviceMock.findUpcoming(any));
        expect(sut.list, []);
        expect(sut.page, 1);
        expect(sut.state, StateEnum.offline);
      },
    );
  });

  group("Verify refreshList", () {
    test(
      "Without internet connection",
      () async {
        findUpcomingMoviesEmptyList();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(false);
        verifyNever(serviceMock.findUpcoming(any));
        expect(sut.list, []);
        expect(sut.page, 1);
        expect(sut.state, StateEnum.offline);
      },
    );

    test(
      "With internet and no data",
      () async {
        findUpcomingMoviesEmptyList();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(true);
        verify(serviceMock.findUpcoming(any)).called(1);
        expect(sut.list, []);
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
      },
    );

    test(
      "With internet and with data",
      () async {
        findUpcomingMoviesFullList();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(true);
        verify(serviceMock.findUpcoming(any)).called(1);
        expect(sut.list, getFakes());
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
      },
    );

    test(
      "Query, with internet and with no data",
      () async {
        String query = "query";
        sut.query = query;
        sut.setState(StateEnum.refresh);
        findByQueryMoviesEmptyList();
        await sut.refreshList(true);
        verify(serviceMock.findByQuery(any, any)).called(1);
        expect(sut.list, []);
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
        expect(sut.query, query);
      },
    );

    test(
      "Query, with internet and with data",
      () async {
        String query = "query";
        sut.query = query;
        findByQueryMoviesFullList();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(true);
        verify(serviceMock.findByQuery(any, any)).called(1);
        expect(sut.list, getFakes());
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
        expect(sut.query, query);
      },
    );

    test(
      "On Timeout Exception",
      () async {
        findThrowException(TimeoutException("New Exception"));
        sut.list = getFakes();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(true);
        verify(serviceMock.findUpcoming(any)).called(1);
        expect(sut.list, getFakes());
        expect(sut.page, 1);
        expect(sut.state, StateEnum.offline);
      },
    );

    test(
      "On Generic Exception",
      () async {
        findThrowException(Exception("New Exception"));
        sut.list = getFakes();
        sut.setState(StateEnum.refresh);
        await sut.refreshList(true);
        verify(serviceMock.findUpcoming(any)).called(1);
        expect(sut.list, getFakes());
        expect(sut.page, 1);
        expect(sut.state, StateEnum.idle);
      },
    );
  });
}
