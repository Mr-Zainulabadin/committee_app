import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kameti_app/utils/appConst.dart';

extension NavigaTion on Widget {
  dynamic get navigate => Get.to(this, transition: Transition.fadeIn);
  dynamic get back => Get.off(this);
}

extension ContextExtension on BuildContext {
  double get mqWidth => MediaQuery.sizeOf(this).width;
  double get mqHeight => MediaQuery.sizeOf(this).height;
}

extension StringExtension on String {
  dynamic get successSnack => AppUtils.snackBarMessage(this);
  dynamic get errorSnack => AppUtils.snackBarErrorMessage(this);
}

extension EmptySpacer on num {
  SizedBox get verSpace => SizedBox(height: toDouble());
  SizedBox get horSpace => SizedBox(width: toDouble());
}
