import 'package:flutter/material.dart';

class Dimen {
  static const double ParentMargin = 16.0;
  static const double RegularMargin = 8.0;
  static const double LargeMargin = 20.0;
  static const double BorderRadius2 = 8.0;
  static const double BorderRadiusRounded = 30.0;
  static const double TextFieldHeight = 32.0;

  static get RegularPadding => EdgeInsets.all(ParentMargin);
  static get Border => BorderRadius.all(Radius.circular(BorderRadiusRounded));

}