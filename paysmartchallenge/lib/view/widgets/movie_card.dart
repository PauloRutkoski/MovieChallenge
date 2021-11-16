import 'package:flutter/material.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';
import 'package:paysmartchallenge/view/utils/formatter.dart';
import 'package:paysmartchallenge/view/utils/image_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;
  const MovieCard(this.movie, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      width: 100,
      height: 150,
      child: movie.posterPath == null || movie.posterPath!.isEmpty
          ? _onErrorImage()
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                ImageUtils.getSmUri(movie.posterPath ?? ""),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _onErrorImage(),
              ),
            ),
    );
  }

  Widget _onErrorImage() {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: Icon(Icons.cancel),
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
            movie.title ?? "",
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
          child: Text(Formatter.genresText(movie)),
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
}
