import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healmeumpapp/core/service/connectivity.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({super.key});

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  final CheckConnection _checkConnection = CheckConnection();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<void> _checkLogIn() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final logIn =
          pref.getBool('isLogin') ?? false; // Default ke false jika null
      print("status Login : $logIn");
      final type = pref.getString('type');
      print("type login : $type");

      if (logIn) {
        print("Menuju ke halaman utama");
        GoRouter.of(context).go(PAGESNAMES.home.ScreenPath);
      } else {
        print("Menuju ke halaman login");
        GoRouter.of(context).go(PAGESNAMES.onbroading.ScreenPath);
      }
    } catch (e) {
      // Menangani error apapun yang terjadi
      print("Error terjadi: $e");
      // Navigasi ke halaman login jika ada error
      GoRouter.of(context).go(PAGESNAMES.onbroading.ScreenPath);
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Tidak Ada Internet'),
        content: Text('Periksa koneksi internet Anda dan coba lagi.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkConnectionAndNavigate();
            },
            child: Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkConnectionAndNavigate() async {
    bool isConnected = await _checkConnection.checkInternet();
    if (isConnected) {
      await _checkLogIn();
      // await _checkUpdate();
    } else {
      _showNoInternetDialog();
    }
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), _checkConnectionAndNavigate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logoo.png'),
      ),
    );
  }
}