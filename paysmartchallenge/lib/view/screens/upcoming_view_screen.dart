import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/view/utils/formatter.dart';
import 'package:paysmartchallenge/view/utils/image_utils.dart';
import 'package:paysmartchallenge/view/utils/nav.dart';

class UpcomingViewScreen extends StatefulWidget {
  final Movie movie;
  const UpcomingViewScreen(this.movie, {Key? key}) : super(key: key);

  @override
  _UpcomingViewScreenState createState() => _UpcomingViewScreenState();
}

class _UpcomingViewScreenState extends State<UpcomingViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildImage(context),
        _buildInfo(context),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: IconButton(
            onPressed: () => Nav.back(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          ImageUtils.getLgUri(widget.movie.posterPath ?? ""),
          width: MediaQuery.of(context).size.width,
          loadingBuilder: _onLoadingImage,
          errorBuilder: _onErrorImage,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.1, 0.9],
                  colors: [Colors.transparent, Colors.black])),
        ),
      ],
    );
  }

  Widget _onErrorImage(context, error, stackTrace) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Icon(Icons.cancel),
      ),
    );
  }

  Widget _onLoadingImage(context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.75),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    backgroundBlendMode: BlendMode.dstOut),
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: _info(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _info(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movie.title ?? "",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Release: ${Formatter.ddMMyyyy(widget.movie.release)}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        Text(
          Formatter.genresText(widget.movie),
          textAlign: TextAlign.justify,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.movie.overview ?? "",
          textAlign: TextAlign.justify,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
