import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class AppFunctions {
  static navigateToPage({required BuildContext context, required Widget page}) {
    if (Platform.isIOS) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => page),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  static navigateToPageCustomAnimation(
      {required BuildContext context,
      required Widget page,
      bool isDialog = false}) {
    Navigator.push(
        context,
        PageTransition(
          fullscreenDialog: isDialog,
          type: PageTransitionType.fade,
          child: page,
          duration: const Duration(milliseconds: 300),
        )
        // PageRouteBuilder(
        //   transitionDuration: Duration(milliseconds: 800),
        //   pageBuilder: (context, animation, secondaryAnimation) => page,
        //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //     const begin = Offset(0.0, 1.0);
        //     const end = Offset.zero;
        //     const curve = Curves.ease;

        //     var tween =
        //         Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        //     return SlideTransition(
        //       position: animation.drive(tween),
        //       child: child,
        //     );
        //   },
        // ),
        );
  }

  static String parseDateTimeToHumanReadable(
      {required DateTime? dateTime, required String nullText}) {
    if (dateTime == null) {
      return nullText;
    } else {
      String formattedDate = DateFormat('d MMM, yyyy').format(dateTime);
      return formattedDate;
    }
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      print('Please enter mobile number');
      // return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      print("Please enter valid mobile number");
      // return 'Please enter valid mobile number';
    }
    return "";
  }

  // VALIDATOR FUNCTIONS
  static String? validateEmptyString(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? validateEmptyDateTime(DateTime? value) {
    if (value == null) {
      return 'Date is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    RegExp exp = RegExp(
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (value == null) {
      return 'Filed is required';
    }

    if (!exp.hasMatch(value.trim())) {
      return 'Invalid email address';
    }

    return null;
  }

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // A..F
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }

    return val;
  }

  static String returnText(String? data) {
    if (data == null) {
      return "N/A";
    } else {
      return data;
    }
  }

  static String returnTextWithNullValue(
      {required String? data, required String nullText}) {
    if (data == null || data.isEmpty) {
      return nullText;
    } else {
      return data;
    }
  }

  static String returnParsedPhoneNumber(
      {required String phoneNumber, required String countryDialingCode}) {
    String finalPhoneNumber;

    var regExpRemoveSpecialCharacters = RegExp(r'[^0-9]+');

    String newContact =
        phoneNumber.replaceAll(regExpRemoveSpecialCharacters, '');

    String trimmedContact = newContact.trim();

    // CHECK IF PHONE NUMBER STARTS WITH ZERO
    String firstIndexOfPhoneNumber = trimmedContact[0];

    // if phoneNumber starts with zero, remove  the first index which is 0
    if (firstIndexOfPhoneNumber == "0") {
      finalPhoneNumber = trimmedContact.substring(1);
    } else {
      finalPhoneNumber = trimmedContact;
    }

    if (finalPhoneNumber.length <= 10) {
      // IF IT IS LESS THAN OR EQUAL TO 10 , APPEND THE USERS DIALING CODE TO THE NUMBER
      finalPhoneNumber = countryDialingCode + finalPhoneNumber;
    } else {
      // IF IT IS GREATER THAN  10 , APPEND THE + CODE TO  THE NUMBER
      finalPhoneNumber = "+$finalPhoneNumber";
    }

    return finalPhoneNumber;
  }

  static showSnackBar({
    required BuildContext context,
    required String message,
    int durationInSecs = 4,
    Color backgroundColor = const Color(0xFFB7221F),
  }) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: durationInSecs),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showToast(
      {required String message,
      Color backgroundColor = const Color(0xFFB7221F),
      ToastGravity toastGravity = ToastGravity.BOTTOM,
      toastLength = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static screenPortrait() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static String calculateRaisedAmount({required List<num>? donations}) {
    if (donations == null || donations.isEmpty) {
      return "0.00";
    } else {
      num total = donations.sum;
      return total.toString();
    }
  }

  // static double estimateDeliveryFee({
  //   required String vehicleType,
  //   required num distance,
  //   required num duration,
  //   required num bikeBaseRate,
  //   required num bikeDistanceRate,
  //   required num bikeTimeRate,
  //   required num carBaseRate,
  //   required num carDistanceRate,
  //   required num carTimeRate,
  //   required num truckBaseRate,
  //   required num truckDistanceRate,
  //   required num truckTimeRate,
  // }) {
  //   if (vehicleType == AppStrings.kMOTORBIKE) {
  //     double distanceFare = (distance / 1000) * bikeDistanceRate;
  //     double timeFare = (duration / 60) * bikeTimeRate;
  //     double totalFare = bikeBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   } else if (vehicleType == AppStrings.kMOTORBIKE) {
  //     double distanceFare = (distance / 1000) * bikeDistanceRate;
  //     double timeFare = (duration / 60) * bikeTimeRate;
  //     double totalFare = bikeBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   } else if (vehicleType == AppStrings.kSALOON) {
  //     double distanceFare = (distance / 1000) * carDistanceRate;
  //     double timeFare = (duration / 60) * carTimeRate;
  //     double totalFare = carBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   } else if (vehicleType == AppStrings.kPICKUP) {
  //     double distanceFare = (distance / 1000) * truckDistanceRate;
  //     double timeFare = (duration / 60) * truckTimeRate;
  //     double totalFare = truckBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   } else if (vehicleType == AppStrings.kTRUCK) {
  //     double distanceFare = (distance / 1000) * truckDistanceRate;
  //     double timeFare = (duration / 60) * truckTimeRate;
  //     double totalFare = truckBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   } else if (vehicleType == AppStrings.kTRAILER) {
  //     double distanceFare = (distance / 1000) * truckDistanceRate;
  //     double timeFare = (duration / 60) * truckTimeRate;
  //     double totalFare = truckBaseRate + distanceFare + timeFare;
  //     return totalFare.truncateToDouble();
  //   }

  //   double distanceFare = (distance / 1000) * bikeDistanceRate;
  //   double timeFare = (duration / 60) * bikeTimeRate;
  //   double totalFare = bikeBaseRate + distanceFare + timeFare;
  //   return totalFare.truncateToDouble();
  // }
}
