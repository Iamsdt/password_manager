class GeneratedPassword {
  String pass;
  bool isLowerCase;
  bool isUpperCase;
  bool isNumbers;
  bool isSpecial;

  GeneratedPassword(
    this.pass, {
    bool isLowerCase = true,
    bool isUpperCase = true,
    bool isNumbers = true,
    bool isSpecial = true,
  });
}
