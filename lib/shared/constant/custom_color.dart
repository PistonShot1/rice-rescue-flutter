import 'package:flutter/material.dart';

class CustomColor {
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.background;
  }

  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color getTertieryColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }

  static Color getWhiteColor(BuildContext context) {
    return const Color.fromRGBO(251, 251, 251, 1);
  }

  static Color getBlackColor(BuildContext context) {
    return Colors.black;
  }

  static Color getAppBarGradient() {
    return const Color.fromRGBO(111, 205, 171, 1);
  }

  static Color getFirstPhaseColor() {
    return Colors.grey;
  }

  static Color getSecondPhaseColor() {
    return Colors.yellow.shade700;
  }

  static Color getThirdPhaseColor() {
    return Colors.orange;
  }

  static Color getFourthPhaseColor() {
    return Colors.red;
  }

  static LinearGradient getMainGradient(BuildContext context) {
    return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.fromRGBO(111, 205, 171, 1), Colors.black38]);
  }

  static LinearGradient getPrimaryGradient(BuildContext context) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(187, 225, 211, 1),
        Color.fromRGBO(187, 225, 211, 0.5),
      ],
    );
  }
}
