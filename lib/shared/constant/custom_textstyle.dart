import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle getTitleStyle(
      BuildContext context, double fontsize, Color color) {
    return GoogleFonts.poppins(
        fontSize: fontsize, color: color, fontWeight: FontWeight.w500);
  }

  static TextStyle getSubTitleStyle(
      BuildContext context, double fontsize, Color color) {
    return GoogleFonts.poppins(
        fontSize: fontsize, color: color, fontWeight: FontWeight.w300);
  }

  static TextStyle getUnderlineStyle(
      BuildContext context, double fontsize, Color color) {
    return GoogleFonts.poppins(
        fontSize: fontsize,
        color: color,
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.underline);
  }
}
