import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/global/widget/logout_dialog.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40.h,
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: cPrimary,
                  borderRadius: BorderRadius.only(),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF5F5F5),
                            ),
                            child: Center(
                                child: Text(
                              "G",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: cPrimary,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Halo, Gilang MF",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Selamat datang kembali",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await context.showLogoutDialog(
                                onLogout: () {
                                  // Handle logout logic here
                                  // Clear user data, tokens, etc.
                                  print('User logged out');
                                  
                                  // Navigate to login page
                                  RouterNavigation.router.push(PAGESNAMES.login.ScreenPath);
                                },
                                onCancel: () {
                                  // Handle cancel logic if needed
                                  print('User cancelled logout');
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/icon-logout.png',
                                width: 6.w,
                                height: 3.h,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 13.h,
                        width: sWidthFull(context),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                //spacing: 1.h,
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    "Informasi Pengguna",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Text(
                                    "NIM",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "1234567890",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Text(
                                    "Fakultas",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "FAKULTAS ILMU KESEHATAN",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 10.h,
                        width: sWidthFull(context),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5.w,
                            right: 5.w,
                            top: 2.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 1.w,
                                children: [
                                  // Icon(
                                  //   Icons.lightbulb_circle,
                                  //   color: Colors.white,
                                  // ),
                                  Image.asset('assets/icon-light-on.png'),
                                  Text(
                                      "Tip: Jawab semua pertanyaan berdasarkan",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                              Text(
                                  "pengalaman Anda dalam 1 minggu terakhir untuk hasil yang akurat",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  top: 3.h,
                ),
                child: Container(
                  height: 51.h,
                  width: sWidthFull(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 2.w, top: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pilih tes yang ingin Anda lakukan",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () {
                            RouterNavigation.router
                                .push(PAGESNAMES.mentalHealth.ScreenPath);
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 8.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: cBackground2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                    'assets/icon-brain-dashboard.png'),
                              ),
                              SizedBox(width: 3.w),
                              SizedBox(
                                height: 8.h,
                                width: 50.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 1.h,
                                  children: [
                                    Text(
                                      "Tes Kesehatan Mental",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: cPrimaryText),
                                    ),
                                    Text(
                                      "Tes kesehatan mental komprehensif",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: cPrimaryText),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () {
                            RouterNavigation.router
                                .push(PAGESNAMES.mentalHealth.ScreenPath);
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 8.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFAEBEE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                    'assets/icon-favorite-dashboard.png'),
                              ),
                              SizedBox(width: 3.w),
                              SizedBox(
                                height: 8.h,
                                width: 50.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 1.h,
                                  children: [
                                    Text(
                                      "Tes Depresi",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: cPrimaryText),
                                    ),
                                    Text(
                                      "Evaluasi tingkat depresi Anda",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: cPrimaryText),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () {
                            RouterNavigation.router
                                .push(PAGESNAMES.mentalHealth.ScreenPath);
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 8.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFDF2DB),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                    'assets/icon-flash-on-dashboard.png'),
                              ),
                              SizedBox(width: 3.w),
                              SizedBox(
                                height: 8.h,
                                width: 50.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 1.h,
                                  children: [
                                    Text(
                                      "Tes Kecemasan",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: cPrimaryText),
                                    ),
                                    Text(
                                      "Ukur tingkat kecemasan Anda",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: cPrimaryText),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () {
                            RouterNavigation.router
                                .push(PAGESNAMES.mentalHealth.ScreenPath);
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 8.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEE9FE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                    'assets/icon-pulse-dashboard.png'),
                              ),
                              SizedBox(width: 3.w),
                              SizedBox(
                                height: 8.h,
                                width: 50.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 1.h,
                                  children: [
                                    Text(
                                      "Tes Stres",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: cPrimaryText),
                                    ),
                                    Text(
                                      "Evaluasi Tingkat stres harian",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: cPrimaryText),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14.sp,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                ),
              ),
              // Riwayat Tes Card
              Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  top: 3.h,
                ),
                child: Container(
                  width: sWidthFull(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Riwayat Tes',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: cPrimaryText,
                              ),
                            ),
                            Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: cPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        
                        // Test History Items
                        Column(
                          children: [
                            // Recent Test 1
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                              decoration: BoxDecoration(
                                color: cBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: cPrimary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.psychology,
                                      color: cPrimary,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tes Kesehatan Mental',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: cPrimaryText,
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          'Skor: 25 (Normal)',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.green[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          '2 hari yang lalu',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey[400],
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: 1.5.h),
                            
                            // Recent Test 2
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                              decoration: BoxDecoration(
                                color: cBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12.w,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.orange[600],
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tes Depresi',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: cPrimaryText,
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          'Skor: 18 (Berisiko)',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.orange[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          '1 minggu yang lalu',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey[400],
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Informasi Card
              Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                  top: 3.h,
                ),
                child: Container(
                  width: sWidthFull(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Informasi',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: cPrimaryText,
                          ),
                        ),
                        SizedBox(height: 2.h),

                        // Tentang Aplikasi
                        GestureDetector(
                          onTap: () {
                            // Navigate to about app page
                            RouterNavigation.router.push(PAGESNAMES.about.ScreenPath);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: cPrimary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.info,
                                    color: cPrimary,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Tentang Aplikasi',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: cPrimaryText,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[400],
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Divider
                        Container(
                          height: 1,
                          color: Colors.grey[200],
                        ),

                        // Kontak
                        GestureDetector(
                          onTap: () {
                            RouterNavigation.router.push(PAGESNAMES.support.ScreenPath);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: cPrimary.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: cPrimary,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Kontak',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: cPrimaryText,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[400],
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
