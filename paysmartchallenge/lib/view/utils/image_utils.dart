class ImageUtils {
  static const String _imagePath = "https://image.tmdb.org/t/p/";

  static String getUri(String path) {
    return _imagePath + "/w154" + path;
  }
}
