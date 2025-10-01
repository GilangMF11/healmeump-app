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
        ),
      ),
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
                      color: Colors.black.withValues(alpha: 0.1),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: cPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: cPrimary.withValues(alpha: 0.3),
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
                      color: Colors.black.withValues(alpha: 0.1),
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
                            description:
                                'Skrining komprehensif untuk depresi, kecemasan dan stres dengan 21 pertanyaan terstandarisasi',
                            iconBgColor: Colors.blue[50]!,
                          ),

                          SizedBox(height: 2.h),

                          // Feature 2: BDI-II
                          _buildFeatureItem(
                            icon: 'assets/icon-favorite-dashboard.png',
                            title: 'Tes BDI-II',
                            description:
                                'Beck Depression Inventory-II untuk evaluasi tingkat depresi.',
                            iconBgColor: Colors.red[50]!,
                          ),

                          SizedBox(height: 2.h),

                          // Feature 3: Kecemasan & Stres
                          _buildFeatureItem(
                            icon: 'assets/icon-flash-on-dashboard.png',
                            title: 'Tes Kecemasan & Stres',
                            description:
                                'Evaluasi terpisah untuk tingkat kecemasan dan stres.',
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
                      color: Colors.black.withValues(alpha: 0.1),
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
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Hasil tes ini hanya untuk referensi dan tidak menggantikan diagnosis profesional. Jika Anda mengalami gejala yang mengkhawatirkan, segera konsultasikan dengan tenaga kesehatan mental.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Aplikasi ini diadaptasikan dari alat ukur Kesehatan mental DASS-21, dimana mengukur depresi, kecemasan dan stress.Dua psikolog dari University of New South Wales (UNSW), Australia, yakni Peter F. Lovibond dan Sydney H. Lovibond, memulai sebuah penelitian bertujuan untuk mengembangkan alat ukur yang mampu mengenali  dan membedakan secara jelas tiga kondisi emosional negatif yang paling umum: Depresi (Depression), Kecemasan (Anxiety), dan Stres (Stress).',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Pada tahun 1995, mereka menerbitkan karya monumental mereka di jurnal Behaviour Research and Therapy. Penelitian yang berjudul "The structure of negative emotional states: Comparison of the Depression Anxiety Stress Scales (DASS) with the Beck Depression and Anxiety Inventories" memperkenalkan sebuah skala lengkap dengan 42 item, yang kemudian disebut sebagai DASS-42.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'DASS-42 dengan cepat mendapat tanggapan positif karena mampu menunjukkan struktur tiga faktor yang kuat dan valid, serta membedakan tiga konstruksi dengan jelas yaitu depresi, kecemasan dan stress. ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Lovibond dan Lovibond kemudian menciptakan versi yang lebih pendek. Mereka mengevaluasi data dari DASS-42 dan memilih 21 butir yang paling relevan dan mewakili untuk setiap konstruk tujuh butir untuk depresi, tujuh untuk kecemasan, dan tujuh untuk stres. Versi singkat inilah yan kemudian disebut DASS-21.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'DASS21 bukan hanya versi singkat dari bentuk panjangnya. Berdasarkan analisis statistik, dapat dibuktikan bahwa versi ini memiliki validitas dan reliabilitas yang hampir sama dengan DASS-42. Hubungan yang kuat antara skor subskala DASS-21 dan DASS-42 menjadikan DASS-21 sebagai alat yang sama efektif tetapi jauh lebih praktis.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(height: 2.h),
                      Text(
                        'Sumber: ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Lovibond, P. F., & Lovibond, S. H. (1995). The structure of negative emotional states: Comparison of the Depression Anxiety Stress Scales (DASS) with the Beck Depression and Anxiety Inventories. Behaviour Research and Therapy, 33(3), 335–343. https://doi.org/10.1016/0005-7967(94)00075-U',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
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
