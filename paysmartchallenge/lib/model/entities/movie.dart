import 'package:paysmartchallenge/model/entities/genre.dart';

class Movie {
  int? id;
  String? title;
  String? overview;
  String? posterPath;
  List<Genre>? genres;
  DateTime? release;

  Movie(this.id, this.title, this.overview, this.posterPath, this.genres,
      this.release);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['id'],
      json['title'],
      json['overview'],
      json['poster_path'] ?? "",
      json['genres'],
      json['release_date'] == null || json['release_date'].toString().isEmpty
          ? null
          : DateTime.parse(json['release_date']),
    );
  }
}
