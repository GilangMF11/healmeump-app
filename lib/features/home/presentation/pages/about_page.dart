import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/global/constant/version.dart';
import 'package:sizer/sizer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
          backgroundColor: cPrimary,
          title: Text(
                "Tentang Aplikasi",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 3.h),
              
              // App Information Section
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      // Logo
                      Container(
                        width: 20.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: cBackground2,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // App Name
                      Text(
                        'Heal Me UMP',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      
                      // App Description
                      Text(
                        'Aplikasi Skrining Kesehatan Mental',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: cPrimaryText,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      
                      // Version
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: cPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: cPrimary.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Versi ${Version.version}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: cPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Main Features Section
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Fitur Utama',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // Feature Items
                      Column(
                        children: [
                          // Feature 1: DASS-21
                          _buildFeatureItem(
                            icon: 'assets/icon-brain-dashboard.png',
                            title: 'Tes DASS-21',
                            description: 'Skrining komprehensif untuk depresi, kecemasan dan stres dengan 21 pertanyaan terstandarisasi',
                            iconBgColor: Colors.blue[50]!,
                          ),
                          
                          SizedBox(height: 2.h),
                          
                          // Feature 2: BDI-II
                          _buildFeatureItem(
                            icon: 'assets/icon-favorite-dashboard.png',
                            title: 'Tes BDI-II',
                            description: 'Beck Depression Inventory-II untuk evaluasi tingkat depresi.',
                            iconBgColor: Colors.red[50]!,
                          ),
                          
                          SizedBox(height: 2.h),
                          
                          // Feature 3: Kecemasan & Stres
                          _buildFeatureItem(
                            icon: 'assets/icon-flash-on-dashboard.png',
                            title: 'Tes Kecemasan & Stres',
                            description: 'Evaluasi terpisah untuk tingkat kecemasan dan stres.',
                            iconBgColor: Colors.orange[50]!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Additional Info
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tentang Aplikasi',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Heal Me UMP adalah aplikasi skrining kesehatan mental yang dirancang khusus untuk komunitas Universitas Muhammadiyah Purwokerto. Aplikasi ini menyediakan tes-tes terstandarisasi untuk membantu mengidentifikasi gejala depresi, kecemasan, dan stres.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Hasil tes ini hanya untuk referensi dan tidak menggantikan diagnosis profesional. Jika Anda mengalami gejala yang mengkhawatirkan, segera konsultasikan dengan tenaga kesehatan mental.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem({
    required String icon,
    required String title,
    required String description,
    required Color iconBgColor,
  }) {
    return Row(
      children: [
        // Icon Container
        Container(
          width: 15.w,
          height: 7.h,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 4.w),
        
        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: cPrimaryText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}