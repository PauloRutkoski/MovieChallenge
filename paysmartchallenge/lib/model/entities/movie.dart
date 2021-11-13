import 'package:paysmartchallenge/model/entities/genre.dart';

class Movie {
  int id;
  String title;
  String overview;
  String posterPath;
  List<int> genreIds;
  DateTime release;

  List<Genre>? genres;

  Movie(this.id, this.title, this.overview, this.posterPath, this.genreIds,
      this.release);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        json['id'],
        json['title'],
        json['overview'],
        json['poster_path'],
        List<int>.from(json['genre_ids']),
        DateTime.parse(json['release_date']));
  }
}
