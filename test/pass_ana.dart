import 'package:password_manager/utils/utils.dart';

void main() {
  var pass = "Az0@";
  int res = Utils.analysisPassword(pass);

  assert(res == 80);
}
