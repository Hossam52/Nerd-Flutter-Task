import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class Methods {
  Methods._();
  static Future<dynamic> navigateTo(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static void showErrorSnackBar(BuildContext context, String text,
      [int seconds = 2]) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.red,
    );
  }

  static void showSuccessSnackBar(BuildContext context, String text,
      [int seconds = 2]) async {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.green,
    );
  }

  static String formatDate(DateTime date,
      {String format = 'MM/dd', bool appendYear = false}) {
    if (appendYear) format = 'yyyy/MM/dd';
    return DateFormat(format).format(date);
  }

  static String formatDuration(String isoDuration) {
    final RegExp regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?');
    final Match? match = regex.firstMatch(isoDuration);

    if (match != null) {
      String? hoursStr = match.group(1);
      String? minutesStr = match.group(2);
      String formattedDuration = '';

      if (hoursStr != null) {
        int hours = int.parse(hoursStr);
        formattedDuration += '$hours hour ';
      }
      if (minutesStr != null) {
        int minutes = int.parse(minutesStr);
        formattedDuration += '$minutes min';
      }

      return formattedDuration
          .trim(); // Removes any extra spaces if there are no minutes
    } else {
      throw FormatException('Invalid duration format');
    }
  }
}

extension SizeExtensions on BuildContext {
  double get getWidth => size!.width;
  double get getHeight => size!.height;
  double getFactorWidth(double factor) => getWidth * factor;
  double getFactorHeight(double factor) => getHeight * factor;
}
