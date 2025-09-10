import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class MentalHealthResultPage extends StatefulWidget {
  const MentalHealthResultPage({super.key});

  @override
  State<MentalHealthResultPage> createState() => _MentalHealthResultPageState();
}

class _MentalHealthResultPageState extends State<MentalHealthResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Hasil Tes Kesehatan Mental",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 3.h,
            left: 5.w,
            right: 5.w,
          ),
          child: Column(
            children: [
              // Result Summary Card
              Container(
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
                    children: [
                      // Success Icon
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 12.w,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // Title
                      Text(
                        "Tes Selesai!",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      
                      // Description
                      Text(
                        "Terima kasih telah menyelesaikan tes kesehatan mental DASS-21. Berikut adalah hasil analisis berdasarkan jawaban Anda.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Results Cards
              _buildResultCard(
                "Depresi",
                "Normal",
                Colors.green,
                "Skor Anda menunjukkan tingkat depresi yang normal. Anda tidak menunjukkan tanda-tanda depresi yang signifikan.",
                "0-9",
              ),
              
              SizedBox(height: 2.h),
              
              _buildResultCard(
                "Kecemasan",
                "Ringan",
                Colors.orange,
                "Skor Anda menunjukkan tingkat kecemasan ringan. Pertimbangkan untuk melakukan relaksasi dan teknik manajemen stres.",
                "10-14",
              ),
              
              SizedBox(height: 2.h),
              
              _buildResultCard(
                "Stres",
                "Normal",
                Colors.green,
                "Skor Anda menunjukkan tingkat stres yang normal. Anda dapat mengelola stres dengan baik dalam kehidupan sehari-hari.",
                "0-14",
              ),
              
              SizedBox(height: 3.h),
              
              // Recommendations Card
              Container(
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
                      Text(
                        "Rekomendasi",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      _buildRecommendationItem(
                        Icons.self_improvement,
                        "Praktik Relaksasi",
                        "Lakukan teknik pernapasan dalam, meditasi, atau yoga untuk mengurangi kecemasan.",
                      ),
                      
                      SizedBox(height: 1.5.h),
                      
                      _buildRecommendationItem(
                        Icons.sports,
                        "Aktivitas Fisik",
                        "Olahraga teratur dapat membantu mengurangi stres dan meningkatkan mood.",
                      ),
                      
                      SizedBox(height: 1.5.h),
                      
                      _buildRecommendationItem(
                        Icons.people,
                        "Dukungan Sosial",
                        "Jaga hubungan dengan keluarga dan teman. Berbicara tentang perasaan dapat membantu.",
                      ),
                      
                      SizedBox(height: 1.5.h),
                      
                      _buildRecommendationItem(
                        Icons.schedule,
                        "Rutinitas Sehat",
                        "Jaga pola tidur yang teratur, makan makanan bergizi, dan hindari konsumsi berlebihan.",
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        RouterNavigation.router.push(PAGESNAMES.mentalHealth.ScreenPath);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: cBackground,
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Ulangi Tes",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: cPrimaryText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        RouterNavigation.router.push(PAGESNAMES.home.ScreenPath);
                      },
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: cPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Kembali ke Beranda",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(String category, String level, Color color, String description, String scoreRange) {
    return Container(
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
        child: Row(
          children: [
            // Category Icon
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: color,
                size: 6.w,
              ),
            ),
            SizedBox(width: 3.w),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          level,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "Skor: $scoreRange",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: cPrimary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: cPrimary,
            size: 4.w,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Depresi":
        return Icons.mood_bad;
      case "Kecemasan":
        return Icons.psychology;
      case "Stres":
        return Icons.flash_on;
      default:
        return Icons.health_and_safety;
    }
  }
}