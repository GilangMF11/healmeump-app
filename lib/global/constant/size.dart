import 'package:flutter/material.dart';

double sHeightFull(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top;
}

double sHeightDynamic(BuildContext context, double value) {
  return MediaQuery.of(context).size.height * value;
}

double sHeightMinus(BuildContext context, double value) {
  return MediaQuery.of(context).size.height - value - MediaQuery.of(context).viewPadding.top;
}

double sHighBottomBar(BuildContext context) {
  return 55.0;
}

double sHightContainWithBar(BuildContext context) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top - 60;
}

double sHightRoomHeader(BuildContext context) {
  return 70.0;
}

double sKeyboard(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom;
}

double sHightKeyboardShow(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).viewPadding.top -
      MediaQuery.of(context).viewInsets.bottom -
      70;
}

double sWidthFull(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double sWidthDynamic(BuildContext context, double value) {
  return MediaQuery.of(context).size.width * value;
}

double sWidthMinus(BuildContext context, double value) {
  return MediaQuery.of(context).size.width - value;
}

