import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isMahasiswa = true; // true for Mahasiswa, false for Dosen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
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
                                    color: _isMahasiswa ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Row(
                                      spacing: 1.w,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 14.sp,
                                          color: _isMahasiswa ? cPrimary : Colors.grey,
                                        ),
                                        Text(
                                          'Mahasiswa',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: _isMahasiswa ? cPrimary : Colors.grey,
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
                                    color: !_isMahasiswa ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Row(
                                      spacing: 1.w,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_2_outlined,
                                          size: 14.sp,
                                          color: !_isMahasiswa ? cPrimary : Colors.grey,
                                        ),
                                        Text(
                                          'Dosen',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: !_isMahasiswa ? cPrimary : Colors.grey,
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
                          decoration: InputDecoration(
                            hintText: _isMahasiswa ? "Masukan NIM Anda" : "Masukan NIP Anda",
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
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: _isMahasiswa ? "Password SIA Anda" : "Password SIMPEG Anda",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: cPrimary,
                            ),
                            suffixIcon: Icon(Icons.visibility_off_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F5F9),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      width: sWidthFull(context),
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: cPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
    );
  }
}
