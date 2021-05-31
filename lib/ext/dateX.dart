extension DateX on DateTime {
  String toLogDate() {
    return "${this.day}/${this.month} -> ${this.hour}:${this.minute}:${this.second}";
  }

  String readableString() => "$day/$month/$year";
}
