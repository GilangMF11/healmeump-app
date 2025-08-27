import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo dan Icon
            Container(
              width: 25.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: cBackground2,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 3.h),
            
            // Title
            Text(
              'Halaman Tidak Ditemukan',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            
            // Description
            Text(
              'Maaf, halaman yang Anda cari tidak dapat ditemukan atau telah dipindahkan.',
              style: TextStyle(
                fontSize: 14.sp,
                color: cPrimaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            
            // Error Code (Optional)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                'Error 404',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            
            // Back to Home Button
            GestureDetector(
              onTap: () {
                RouterNavigation.router.push(PAGESNAMES.onbroading.ScreenPath);
              },
              child: Container(
                width: sWidthFull(context),
                height: 6.h,
                decoration: BoxDecoration(
                  color: cPrimary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: cPrimary.withValues(alpha:0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Kembali ke Beranda',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            
            // Alternative: Back Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: sWidthFull(context),
                height: 5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cPrimary),
                ),
                child: Center(
                  child: Text(
                    'Kembali',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
