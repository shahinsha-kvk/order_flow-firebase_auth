import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../services/google_auth_service.dart';
import '../services/phone_auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final GoogleAuthService _googleService = GoogleAuthService();
  final PhoneAuthService _phoneService = PhoneAuthService();

  AppUser? user;
  String? error;
  String? _verificationId;

  //Check Internet
  Future<bool> checkInternet() async {
    bool internetAvailable = true;
    var connectivityResultList = await (Connectivity().checkConnectivity());
    var connectivityResult = connectivityResultList[0];
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      internetAvailable = true;
      log('have internet connection');
      return internetAvailable;
    } else {
      log('no internet connection');
      internetAvailable = false;
      return internetAvailable;
    }
  }

  String? uiSnackBarMessage;
  Future<bool> _ensureInternet() async {
    log("moon");
    final hasInternet = await checkInternet();
    if (!hasInternet) {
      uiSnackBarMessage = 'No internet. Please check your network connection.';
      notifyListeners();
      return false;
    }
    return true;
  }

  //google login
  Future<bool> loginWithGoogle() async {
    setLoading(true);

    try {
      final firebaseUser = await _googleService.signInWithGoogle();

      if (firebaseUser != null) {
        user = AppUser(
          uid: firebaseUser.uid,
          email: firebaseUser.email,
        );
        return true;
      }
      return false;
    } catch (e) {
      uiSnackBarMessage = 'Login failed';
      setLoading(false);
      return false;
    }
  }

//sent otp
  Future<bool> sendOtp(String phone) async {
    setLoading(true);
    if (!await _ensureInternet()) {
      uiSnackBarMessage = 'No internet. Please check your network connection.';
      setLoading(false);
      return false;
    }

    try {
      await _phoneService.sendOtp(
        phoneNumber: phone,
        onCodeSent: (id) {
          _verificationId = id;
        },
        onError: (msg) {
          throw Exception(msg);
        },
      );

      return true;
    } catch (e) {
      uiSnackBarMessage = e.toString();
      setLoading(false);
      return false;
    }
  }

  //verify otp
  Future<bool> verifyOtp(String otp) async {
    if (_verificationId == null) {
      uiSnackBarMessage = 'Session expired. Please resend OTP.';
      return false;
    }

    log('verifyOtp VM');
    setLoading(true);

    if (!await _ensureInternet()) {
      uiSnackBarMessage = 'No internet. Please check your network connection.';
      setLoading(false);
      return false;
    }

    try {
      final firebaseUser = await _phoneService.verifyOtp(
        verificationId: _verificationId!,
        otp: otp,
      );

      if (firebaseUser != null) {
        user = AppUser(
          uid: firebaseUser.uid,
          phone: firebaseUser.phoneNumber,
          email: firebaseUser.email,
        );

        setLoading(false);
        return true;
      }

      uiSnackBarMessage = 'Invalid OTP';
      setLoading(false);
      return false;
    } catch (e) {
      error = e.toString();
      uiSnackBarMessage = 'OTP verification failed';
      setLoading(false);
      return false;
    }
  }

//log out
  Future<bool> logout() async {
    log('logout progress');
    setLoading(true);
    log('message');

    if (!await _ensureInternet()) {
      uiSnackBarMessage = 'No internet. Please check your network connection.';
      setLoading(false);
      return false;
    }

    try {
      // Google sign out
      await _googleService.signOut();
      // Firebase sign out
      await FirebaseAuth.instance.signOut();
      // Clear local state
      user = null;
      error = null;
      _verificationId = null;
      setLoading(false);
      return true;
    } catch (e) {
      log('logout error: $e');
      uiSnackBarMessage = 'Logout failed. Please try again.';
      setLoading(false);
      return false;
    }
  }
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
