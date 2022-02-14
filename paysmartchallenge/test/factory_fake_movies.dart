import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';

class FactoryFakeMovies {
  static Movie build(int value) {
    return Movie(
      value,
      "Title $value",
      "Overview $value",
      "path/$value",
      [Genre(value, "Genre $value")],
      DateTime(2020),
    );
  }
}
