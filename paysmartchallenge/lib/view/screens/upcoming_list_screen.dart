import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paysmartchallenge/controller/upcoming_list_bloc.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:paysmartchallenge/view/widgets/movie_card.dart';

class UpcomingListScreen extends StatefulWidget {
  const UpcomingListScreen({Key? key}) : super(key: key);

  @override
  _UpcomingListScreenState createState() => _UpcomingListScreenState();
}

class _UpcomingListScreenState extends State<UpcomingListScreen> {
  final _bloc = UpcomingListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.stateStream,
      builder: (context, snapshot) {
        if (snapshot.data == StateEnum.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          child: ListView.builder(
            itemCount: _bloc.list.length,
            itemBuilder: (context, index) {
              Movie movie = _bloc.list[index];
              return MovieCard(movie);
            },
          ),
        );
      },
    );
  }
}
