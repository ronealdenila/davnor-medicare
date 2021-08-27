import 'package:flutter/material.dart';

// The Snippet code has just been copied from my development starter pack.
//Feel free to change/modify them. (R)

const Widget horizontalSpace5 = SizedBox(width: 5);
const Widget horizontalSpace10 = SizedBox(width: 10);
const Widget horizontalSpace15 = SizedBox(height: 15);
const Widget horizontalSpace18 = SizedBox(width: 18);
const Widget horizontalSpace20 = SizedBox(width: 20);
const Widget horizontalSpace25 = SizedBox(width: 25);
const Widget horizontalSpace75 = SizedBox(width: 50);

const Widget verticalSpace5 = SizedBox(height: 5);
const Widget verticalSpace10 = SizedBox(height: 10);
const Widget verticalSpace15 = SizedBox(height: 15);
const Widget verticalSpace18 = SizedBox(height: 18);
const Widget verticalSpace20 = SizedBox(height: 20);
const Widget verticalSpace25 = SizedBox(height: 25);
const Widget verticalSpace50 = SizedBox(height: 50);

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
