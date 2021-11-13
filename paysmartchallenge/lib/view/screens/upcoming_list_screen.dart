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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc.refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Movies"),
      ),
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
          key: const ValueKey<int>(1),
          controller: _scrollController,
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
