import 'package:get/get.dart';
import '../auth/view/login_screen.dart';
import '../auth/view/otp_screen.dart';
import '../auth/view/phone_login_screen.dart';
import '../home/view/cart_screen.dart';
import '../home/view/home_screen.dart';

List<GetPage<dynamic>> getPages() {
  return[
    GetPage(
      name: '/Login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/Home',
      page: () => HomeScreen(),
    ),
    GetPage(
      name: '/Phone',
      page: () => PhoneLoginScreen(),
    ),
    GetPage(
      name: '/Otp',
      page: () => OtpScreen(),
    ),
    GetPage(
      name: '/Cart',
      page: () => CartScreen(),
    ),
  ];
}