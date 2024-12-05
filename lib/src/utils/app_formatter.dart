import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

class AppFormatter {
  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String formatDDMMYYYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
  static String formatYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  static DateTime formatStringToDate(String date) {
    return DateFormat('dd-MM-yyyy').parse(date);
  }

  /*static DateTime formatStringToDate(String date) {
    return DateFormat('dd/MMM/yyyy').parse(date);
  }*/

  static String formatDDMMMYYYY(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatDayDateString(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatBookingDateString(DateTime date) {
    return DateFormat('EEE, d MMM yyyy').format(date);
  }

  static String formatBookingDateListString(DateTime date) {
    return DateFormat("EEE, d MMM ''yy").format(date);
  }

  static String formatDayDateStringWithTime(DateTime date) {
    return DateFormat("EEE, d MMM ''yy hh:mm a").format(date);
  }
  static String formatDyMMMMd(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
static String formatStringDateToDyMMMMd(String date){
     DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat("d MMMM y").format(parsedDate);
      return formattedDate;
}
  static String formatDoubleTimeString(double time) {
    int rounded = time.round();
    if(rounded>12){
      rounded = rounded-12;
    }
    return  "${rounded.toString().padLeft(2,"0")}:00 ${time.round()>=12 ? "PM" : "AM"}"; //;
  }

  static String formatDouble24TimeString(double time) {
    int rounded = time.round();
    return  "${rounded.toString().padLeft(2,"0")}:00"; //;
  }
  
  
  static bool isCurrentDate(String date){
     DateTime parsedDate = DateTime.parse(date);
  DateTime currentDate = DateTime.now();

  // Compare dates (ignoring time)
  bool isCurrentDate = parsedDate.year == currentDate.year &&
      parsedDate.month == currentDate.month &&
      parsedDate.day == currentDate.day;
      return isCurrentDate;
  }

  static toAge(DateTime? dateTime) {
    int age = 0;
    if (dateTime != null) {
      age = DateTime.now().difference(dateTime).inDays ~/ 365;
    }
    return '$age Yrs';
  }

  static convertSecToDay(int hour)
  {
    int day = (hour / 24).truncate();

    int hours = hour.remainder(24);

    return "$day days ${hours>0 ? " $hours hrs" : "" } ";
  }

  static toBase64FromPath(path){
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }
}

extension AddMonthExtension on DateTime{
  DateTime addMonths(int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = year + q;
    var newMonth = month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(day, _daysInMonth(newYear, newMonth));
    if (isUtc) {
      return DateTime.utc(newYear, newMonth, newDay, hour, minute,
          second, millisecond, microsecond);
    } else {
      return DateTime(newYear, newMonth, newDay, hour, minute,
          second, millisecond, microsecond);
    }
  }

  int _daysInMonth(int year, int month) {
    var result = _daysInMonthArray[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }
  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  static const _daysInMonthArray = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
}

extension IsSameDateAs on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}
