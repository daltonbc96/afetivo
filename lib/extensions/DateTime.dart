extension DateExtension on DateTime {
  DateTime get date => DateTime(this.year, this.month, this.day);
  bool isBeforeDate(DateTime other) => this.date.isBefore(other.date);
  bool isAfterDate(DateTime other) => this.date.isAfter(other.date);
  bool isBeforeOrAtDate(DateTime other) =>
      this.date.difference(other.date).inDays <= 0;
  bool isAfterOrAtDate(DateTime other) =>
      this.date.difference(other.date).inDays >= 0;
}
