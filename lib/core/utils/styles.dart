import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle style32(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle colorPageTitle(BuildContext context) {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle colorMovieTitle(BuildContext context) {
    return TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 16.sp,
    );
  }

  static TextStyle style14(BuildContext context) {
    return TextStyle(
      fontSize: 14.sp,
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle style6(BuildContext context) {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle label18(BuildContext context) {
    return TextStyle(
        fontSize: 18.sp,
        color: Theme.of(context).disabledColor,
        fontWeight: FontWeight.bold);
  }

  static TextStyle text16(BuildContext context) {
    return TextStyle(
      fontSize: 16.sp,
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle style16(BuildContext context) {
    return TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold);
  }

  static final TextStyle style18 = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
  );

  static TextStyle style24(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle stylee16(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle stylee24(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static final TextStyle stylebold24 = TextStyle(
    color: Colors.black,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
}
