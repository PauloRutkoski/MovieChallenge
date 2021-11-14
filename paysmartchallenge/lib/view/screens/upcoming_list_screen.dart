import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paysmartchallenge/controller/upcoming_list_bloc.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/view/screens/upcoming_view_screen.dart';
import 'package:paysmartchallenge/view/utils/nav.dart';
import 'package:paysmartchallenge/view/utils/state.dart';
import 'package:paysmartchallenge/view/widgets/movie_card.dart';
import 'package:paysmartchallenge/view/widgets/offline_info.dart';

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
    _scrollController.addListener(_scrollListener);
    _bloc.init();
  }

  _scrollListener() async {
    ScrollPosition position = _scrollController.position;
    if (position.pixels == position.maxScrollExtent) {
      _bloc.page++;
      _bloc.setState(StateEnum.refresh);
      await _bloc.refreshList();
    }
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
        if (snapshot.data == StateEnum.offline) {
          return const OfflineInfo();
        }
        return _buildList(snapshot.data);
      },
    );
  }

  Widget _buildList(Object? state) {
    return Scrollbar(
      key: const ValueKey<int>(1),
      thickness: 6.0,
      interactive: true,
      radius: const Radius.circular(5.0),
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _bloc.list.length + 1,
        itemBuilder: (context, index) {
          if (_bloc.list.length == index) {
            return _buildCardRefresh(state);
          }
          Movie movie = _bloc.list[index];
          return MovieCard(
            movie,
            onTap: () async {
              Nav.to(context, UpcomingViewScreen(movie));
            },
          );
        },
      ),
    );
  }

  Widget _buildCardRefresh(Object? state) {
    if (state != StateEnum.refresh) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
