class Utils {
  static int getPassUpdatedDay(DateTime old) {
    var now = DateTime.now();

    var res = now.difference(old);

    return res.inDays ?? 0;
  }

  // As of now it's pretty straightforward way
  // length more than 8 then 20%
  // contains uppercase 20 %
  //contains lowercase 20 %
  // contains number 20%
  //contains special 20%
  // ********** Improve this **********
  static int analysisPassword(String pass) {
    int points = 0;

    //length
    if (pass.length >= 8) points += 20;

    //uppercase
    if (pass.contains(RegExp("[A-Z]"))) points += 20;

    //lowercase
    if (pass.contains(RegExp("[a-z]"))) points += 20;

    //number
    if (pass.contains(RegExp("[0-9]"))) points += 20;

    //special characters
    //trying negative match
    if (pass.contains(RegExp("[^A-Za-z0-9]"))) points += 20;

    return points;
  }
}
