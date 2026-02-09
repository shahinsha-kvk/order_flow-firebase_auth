import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_configs/page_routes.dart';
import 'auth/provider/auth_view_model.dart';
import 'auth/view/login_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'home/provider/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
    )      ],
      child: GetMaterialApp(
        getPages: getPages(),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.green,
        )
      ),
    );
  }
}
