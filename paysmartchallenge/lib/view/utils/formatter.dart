import 'package:paysmartchallenge/model/entities/genre.dart';
import 'package:paysmartchallenge/model/entities/movie.dart';

class Formatter {
  static String ddMMyyyy(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    String day = zerosToLeft(dateTime.day.toString(), 2);
    String month = zerosToLeft(dateTime.month.toString(), 2);
    return "$day/$month/${dateTime.year}";
  }

  static String zerosToLeft(String str, int size) {
    int dif = str.length - size;
    while (dif < 0) {
      str = "0" + str;
      dif++;
    }
    return str;
  }

  static String genresText(Movie movie) {
    String text = "";
    if (movie.genres != null) {
      for (int i = 0; i < movie.genres!.length; i++) {
        if (i != 0) {
          text += ", ";
        }
        Genre genre = movie.genres![i];
        text += genre.name;
      }
    }
    return text;
  }
}
