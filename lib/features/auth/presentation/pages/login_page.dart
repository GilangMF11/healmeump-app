import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool eye = true;
  bool _isMahasiswa = true; // true for Mahasiswa, false for Dosen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.loadingLogin == ResponseValidation.LOADED) {
            if (state.statusLogin == ResponseValidation.SUCCESS) {
              print("Message: ${state.messageLogin}");
              context.go(PAGESNAMES.home.ScreenPath);
              LocalDataSource().saveLogIn(true);
              // Perbaiki logika role berdasarkan tipe user
              LocalDataSource().saveType(_isMahasiswa ? "1" : "2");
              //LocalDataSource().saveRoleUser(_isMahasiswa ? "mahasiswa" : "dosen");
            } else {
              print("Message: ${state.messageLogin}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Kata sandi atau username salah!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.red[600],
                  duration: Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  action: SnackBarAction(
                    label: 'Tutup',
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
                top: MediaQuery.of(context).padding.top + 2.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                             MediaQuery.of(context).padding.top - 
                             MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                  width: sWidthFull(context),
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      top: 2.h,
                    ),
                    child: Column(
                      spacing: 1.h,
                      children: [
                        Container(
                          width: 20.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: cBackground2,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/logo.png',
                          ),
                        ),
                        Text(
                          'Heal Me UMP',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Silahkan masuk jenis akun Anda',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        // Tab Container
                        Container(
                          width: sWidthFull(context),
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                // Mahasiswa Tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMahasiswa = true;
                                      });
                                    },
                                    child: Container(
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                        color: _isMahasiswa
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Row(
                                          spacing: 1.w,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 14.sp,
                                              color: _isMahasiswa
                                                  ? cPrimary
                                                  : Colors.grey,
                                            ),
                                            Text(
                                              'Mahasiswa',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: _isMahasiswa
                                                    ? cPrimary
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Dosen Tab
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isMahasiswa = false;
                                      });
                                    },
                                    child: Container(
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                        color: !_isMahasiswa
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Row(
                                          spacing: 1.w,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_2_outlined,
                                              size: 14.sp,
                                              color: !_isMahasiswa
                                                  ? cPrimary
                                                  : Colors.grey,
                                            ),
                                            Text(
                                              'Dosen',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: !_isMahasiswa
                                                    ? cPrimary
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Column(
                          spacing: 1.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isMahasiswa ? "NIM" : "NIP",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                hintText: _isMahasiswa
                                    ? "Masukan NIM Anda"
                                    : "Masukan NIP Anda",
                                prefixIcon: Icon(
                                  _isMahasiswa ? Icons.badge : Icons.work,
                                  color: cPrimary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F5F9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: eye,
                              decoration: InputDecoration(
                                hintText: _isMahasiswa
                                    ? "Password SIA"
                                    : "Password SIMPEG",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: cPrimary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    eye
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                    color: cPrimary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      eye = !eye;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F5F9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        GestureDetector(
                          onTap: () {
                            String username = usernameController.text.trim();
                            String password = passwordController.text.trim();
                            if (username.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Username tidak boleh kosong",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: Colors.orange[600],
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Tutup',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            } else if (password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Password tidak boleh kosong",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: Colors.orange[600],
                                  duration: Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Tutup',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            } else {
                              context.read<AuthBloc>().add(
                                    AuthLoginEvent(
                                      username: username,
                                      password: password,
                                      role: _isMahasiswa ? "1" : "2",
                                    ),
                                  );
                            }
                          },
                          child: Container(
                            width: sWidthFull(context),
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: cPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: state.loadingLogin == ResponseValidation.LOADING
                              ? const Center(child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                              : Text(
                                "Masuk",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  ),
);
}
}
