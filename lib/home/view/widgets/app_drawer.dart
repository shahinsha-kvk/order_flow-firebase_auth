import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/ui_helper.dart';
import '../../../auth/provider/auth_view_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  String shortUid(String uid) {
    if (uid.length <= 8) return uid;
    return uid.substring(uid.length - 6).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      width: getWidth(context: context) * 0.95,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          SizedBox(
            height: getHeight(context: context) / 3,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2ECC71),
                    Color(0xFF27AE60),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: getWidth(context: context) / 8,
                        backgroundColor: Colors.white,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL!)
                            : null,
                        child: user?.photoURL == null
                            ? Text(
                          (user?.displayName ?? "🥰")
                              // .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF27AE60),
                          ),
                        )
                            : null,
                      ),
                      verticalSpaceMedium,
                      Text(
                        user?.displayName ?? user?.phoneNumber ?? "No name",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'ID: ${user != null ? shortUid(user.uid) : 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
              return ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  final success = await authViewModel.logout();
                  if (!success) {
                    Themes.showSnackBarError(msg: authViewModel.uiSnackBarMessage ?? 'Unable to logout',);
                    return;
                  }
                  Get.offAllNamed('/Login');
                  Themes.showSuccessSnackBar(msg: 'Logged out successfully',);
                },
              );
            },
          ),

        ],
      ),
    );
  }
}
