import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_12/auth/view/widgets/custom_auth_button.dart';
import 'package:test_12/helpers/ui_helper.dart';
import '../../helpers/app_colors.dart';
import '../provider/auth_view_model.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Center(
        child: Consumer<AuthViewModel>(
          builder: (context, authViewModel, child) {
            if (authViewModel.isLoading) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                child: const CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),strokeWidth: 1),
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(context: context) * 0.22,
                  child: Image.asset('assets/icons/firebase-logo1.png', fit: BoxFit.contain,),
                ),
                SizedBox(height: getHeight(context: context) * 0.22),
                CustomAuthButton(
                  label: 'Google',
                  assetImagePath: 'assets/icons/google-logo1.png',
                  bgColor: AppColors.buttonBlue,
                  onTap: () async {
                    await authViewModel.loginWithGoogle();

                    if (authViewModel.uiSnackBarMessage != null) {
                      Themes.showSnackBar(msg: authViewModel.uiSnackBarMessage!,);
                      authViewModel.uiSnackBarMessage = null;
                      return; }


                    if (authViewModel.user != null) {
                      final firebaseUser = FirebaseAuth.instance.currentUser;
                      final userName = firebaseUser?.displayName ?? firebaseUser?.email ?? 'User';
                      debugPrint('Google login success');
                      Get.offAllNamed('/Home');
                      Themes.showSuccessSnackBar(msg: 'Welcome $userName 👋',);
                    }
                  },
                ),

                CustomAuthButton(
                  label: 'Phone',
                  assetImagePath: 'assets/icons/phone-logo1.png',
                  onTap: () async => Get.toNamed('/Phone'),
                  bgColor: AppColors.buttonGreen,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
