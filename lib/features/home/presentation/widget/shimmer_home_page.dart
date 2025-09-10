import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerHomePage extends StatelessWidget {
  const ShimmerHomePage({super.key});

  // Helper method untuk membuat test item shimmer yang lebih detail
  Widget _buildTestItemShimmer(String title, String subtitle) {
    return Row(
      children: [
        // Icon container shimmer dengan ukuran yang sesuai
        Container(
          height: 8.h,
          width: 20.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 3.w),
        // Text content shimmer dengan panjang yang realistis
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title shimmer dengan panjang yang bervariasi
              Container(
                width: _getTitleWidth(title),
                height: 2.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 1.h),
              // Subtitle shimmer dengan panjang yang bervariasi
              Container(
                width: _getSubtitleWidth(subtitle),
                height: 1.5.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        // Arrow icon shimmer
        Container(
          width: 3.w,
          height: 2.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  // Helper method untuk menentukan lebar title berdasarkan panjang text
  double _getTitleWidth(String title) {
    switch (title) {
      case "Tes Kesehatan Mental":
        return 65.w;
      case "Tes Depresi":
        return 35.w;
      case "Tes Kecemasan":
        return 40.w;
      case "Tes Stres":
        return 30.w;
      default:
        return 50.w;
    }
  }

  // Helper method untuk menentukan lebar subtitle berdasarkan panjang text
  double _getSubtitleWidth(String subtitle) {
    switch (subtitle) {
      case "Tes kesehatan mental komprehensif":
        return 80.w;
      case "Evaluasi tingkat depresi Anda":
        return 70.w;
      case "Ukur tingkat kecemasan Anda":
        return 65.w;
      case "Evaluasi Tingkat stres harian":
        return 70.w;
      default:
        return 60.w;
    }
  }

  // Helper method untuk membuat history item shimmer
  Widget _buildHistoryItemShimmer(String title, String score, String date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Icon container shimmer
          Container(
            width: 12.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 3.w),
          // Text content shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                Container(
                  width: _getHistoryTitleWidth(title),
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 0.5.h),
                // Score shimmer
                Container(
                  width: _getScoreWidth(score),
                  height: 1.5.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 0.5.h),
                // Date shimmer
                Container(
                  width: _getDateWidth(date),
                  height: 1.2.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          // Arrow icon shimmer
          Container(
            width: 3.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods untuk history item widths
  double _getHistoryTitleWidth(String title) {
    switch (title) {
      case "Tes Kesehatan Mental":
        return 65.w;
      case "Tes Depresi":
        return 35.w;
      default:
        return 50.w;
    }
  }

  double _getScoreWidth(String score) {
    switch (score) {
      case "Skor: 25 (Normal)":
        return 50.w;
      case "Skor: 18 (Berisiko)":
        return 55.w;
      default:
        return 45.w;
    }
  }

  double _getDateWidth(String date) {
    switch (date) {
      case "2 hari yang lalu":
        return 40.w;
      case "1 minggu yang lalu":
        return 50.w;
      default:
        return 35.w;
    }
  }

  // Helper method untuk membuat info item shimmer
  Widget _buildInfoItemShimmer(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          // Icon container shimmer
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 3.w),
          // Text shimmer dengan panjang yang sesuai
          Expanded(
            child: Container(
              width: _getInfoTitleWidth(title),
              height: 2.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Arrow icon shimmer
          Container(
            width: 3.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  double _getInfoTitleWidth(String title) {
    switch (title) {
      case "Tentang Aplikasi":
        return 45.w;
      case "Kontak":
        return 25.w;
      default:
        return 35.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Test Selection Card Shimmer
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
              top: 3.h,
            ),
            child: Container(
              height: 54.h,
              width: double.infinity,
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
                padding: EdgeInsets.only(
                    left: 5.w, right: 2.w, top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title shimmer - "Pilih tes yang ingin Anda lakukan"
                    Container(
                      width: 70.w,
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    
                    // Test items shimmer (4 items) dengan detail yang lebih spesifik
                    _buildTestItemShimmer("Tes Kesehatan Mental", "Tes kesehatan mental komprehensif"),
                    SizedBox(height: 3.h),
                    _buildTestItemShimmer("Tes Depresi", "Evaluasi tingkat depresi Anda"),
                    SizedBox(height: 3.h),
                    _buildTestItemShimmer("Tes Kecemasan", "Ukur tingkat kecemasan Anda"),
                    SizedBox(height: 3.h),
                    _buildTestItemShimmer("Tes Stres", "Evaluasi Tingkat stres harian"),
                  ],
                ),
              ),
            ),
          ),
          
          // Test History Card Shimmer
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
              top: 3.h,
            ),
            child: Container(
              width: double.infinity,
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
                    // Title row shimmer - "Riwayat Tes" dan "Lihat Semua"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30.w,
                          height: 2.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          width: 25.w,
                          height: 2.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    
                    // History items shimmer dengan detail yang lebih spesifik
                    _buildHistoryItemShimmer("Tes Kesehatan Mental", "Skor: 25 (Normal)", "2 hari yang lalu"),
                    SizedBox(height: 1.5.h),
                    _buildHistoryItemShimmer("Tes Depresi", "Skor: 18 (Berisiko)", "1 minggu yang lalu"),
                  ],
                ),
              ),
            ),
          ),
          
          // Information Card Shimmer
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 5.w,
              top: 3.h,
            ),
            child: Container(
              width: double.infinity,
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
                    // Title shimmer - "Informasi"
                    Container(
                      width: 25.w,
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    
                    // Information items shimmer dengan detail yang lebih spesifik
                    _buildInfoItemShimmer("Tentang Aplikasi"),
                    // Divider shimmer
                    Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    _buildInfoItemShimmer("Kontak"),
                  ],
                ),
              ),
            ),
          ),
          
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}