class Utils {
  static int getPassUpdatedDay(DateTime old) {
    var now = DateTime.now();

    var res = now.difference(old);

    return res.inDays ?? 0;
  }
}
