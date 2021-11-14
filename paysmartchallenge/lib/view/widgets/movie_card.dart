import 'package:flutter/material.dart';
import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/view/utils/formatter.dart';
import 'package:paysmartchallenge/view/utils/image_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _image(),
              _info(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    Widget image = const Icon(Icons.cancel);
    if (movie.posterPath.isNotEmpty) {
      image = Image.network(
        ImageUtils.getUri(movie.posterPath),
        fit: BoxFit.cover,
      );
    }
    return SizedBox(
      width: 100,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: image,
      ),
    );
  }

  Widget _info(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _title(context),
            const SizedBox(
              height: 5,
            ),
            _genres(),
            _releaseDate(),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            movie.title,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }

  Widget _genres() {
    return Row(
      children: [
        Expanded(
          child: Text(_genresText()),
        ),
      ],
    );
  }

  Widget _releaseDate() {
    return Row(
      children: [
        Expanded(
          child: Text(
            Formatter.ddMMyyyy(movie.release),
          ),
        ),
      ],
    );
  }

  String _genresText() {
    String text = "";
    for (int i = 0; i < movie.genres.length; i++) {
      if (i != 0) {
        text += ", ";
      }
      Genre genre = movie.genres[i];
      text += genre.name;
    }
    return text;
  }
}
