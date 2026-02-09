import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_12/auth/view/widgets/custom_auth_button.dart';
import 'package:test_12/auth/view/widgets/custom_auth_textfield.dart';
import 'package:test_12/helpers/app_colors.dart';
import '../../helpers/ui_helper.dart';
import '../provider/auth_view_model.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final TextEditingController otpCtrl = TextEditingController();

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
          backgroundColor: AppColors.bgWhite,
          title: const Text('Verify OTP')),
      body: Center(
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAuthTextField(
                  controller: otpCtrl,
                  hintText: 'Enter OTP',
                  keyboardType: TextInputType.number,
                ),

                CustomAuthButton(
                  label: 'Verify OTP',
                  assetImagePath: 'assets/icons/phone-logo1.png',
                  bgColor: AppColors.buttonBlue,
                  onTap: vm.isLoading
                      ? null
                      : () async {
                    final success = await vm.verifyOtp(otpCtrl.text.trim());

                    if (!success) {
                      Themes.showSnackBarError(msg: vm.uiSnackBarMessage ?? 'Verification failed',);
                      return;
                    }

                    final firebaseUser = FirebaseAuth.instance.currentUser;
                    final userName = firebaseUser?.displayName ?? firebaseUser?.email ?? firebaseUser?.phoneNumber ?? 'User';
                    Get.offNamed('/Home');
                    Themes.showSuccessSnackBar(msg: 'Welcome $userName 👋',);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
