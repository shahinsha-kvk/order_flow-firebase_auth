import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:test_12/auth/view/widgets/custom_auth_button.dart';
import 'package:test_12/auth/view/widgets/custom_auth_textfield.dart';
import 'package:test_12/helpers/app_colors.dart';
import '../../helpers/ui_helper.dart';
import '../provider/auth_view_model.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});

  final TextEditingController phoneCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        title: const Text('Phone Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAuthTextField(
                    controller: phoneCtrl,
                    hintText: 'Enter 10 digit phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number is required';
                      }

                      final phone = value.trim();

                      if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
                        return 'Enter a valid 10 digit phone number';
                      }

                      return null;
                    },
                  ),

                  CustomAuthButton(
                    label: 'Send OTP',
                    assetImagePath: 'assets/icons/message-icon.png',
                    bgColor: AppColors.buttonGreen,
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final success = await vm.sendOtp('+91${phoneCtrl.text.trim()}');

                      if (!success) {
                        Themes.showSnackBarError(msg: vm.uiSnackBarMessage ?? 'Something went wrong',);
                        return;
                      }
                      Get.offAllNamed('/Otp');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
