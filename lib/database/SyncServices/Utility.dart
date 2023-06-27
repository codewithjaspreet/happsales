class Utility{

  static String getEmptyIfNull(String str) {
  if (str == null || str.trim().toLowerCase() == "null" || str.trim().isEmpty) {
    return "";
  }
  return str;
}

}