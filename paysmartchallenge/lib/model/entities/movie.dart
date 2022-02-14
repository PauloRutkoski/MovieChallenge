import 'package:flutter/cupertino.dart';
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Movie && other.id != null && id != null && id == other.id;
  }

  @override
  int get hashCode => hashValues(id, title);
}
