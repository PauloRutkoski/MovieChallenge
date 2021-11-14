class ImageUtils {
  static const String _imagePath = "https://image.tmdb.org/t/p";

  static String getSmUri(String path) {
    return _imagePath + "/w154" + path;
  }

  static String getLgUri(String path) {
    return _imagePath + "/w500" + path;
  }
}
