import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

double getHeight({required BuildContext context}) => MediaQuery.of(context).size.height;
double getWidth({required BuildContext context}) => MediaQuery.of(context).size.width;

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceMedium = SizedBox(height: 12.0);

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);

class Themes {
  static void showSnackBar({required String msg}) {
    final screenWidth = Get.width;
    Get.snackbar(
      'Warning!',
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.transparentBlack,
      colorText: Colors.black,
      borderRadius: screenWidth * 0.02,
      margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, screenWidth * 0.02, screenWidth * 0.01,),
      duration: const Duration(seconds: 3),
    );
  }

  static void showSnackBarError({required String msg}) {
    final screenWidth = Get.width;
    Get.snackbar(
      'Error',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.iconRedTransparent,
      colorText: Colors.black,
      borderRadius: screenWidth * 0.02,
      margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, screenWidth * 0.02, screenWidth * 0.01,),
      duration: const Duration(seconds: 4),
    );
  }

  static void showSuccessSnackBar({required String msg}) {
    final screenWidth = Get.width;
    Get.snackbar(
      'Success',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.transparentGreen,
      colorText: Colors.black,
      borderRadius: screenWidth * 0.02,
      margin: EdgeInsets.fromLTRB(screenWidth * 0.02, 0, screenWidth * 0.02, screenWidth * 0.01,),
      duration: const Duration(seconds: 2),
    );
  }
}
