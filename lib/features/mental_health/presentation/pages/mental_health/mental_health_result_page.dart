import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';
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
      body: BlocBuilder<MentalhealthBloc, MentalhealthState>(
        builder: (context, state) {
          // Loading state
          if (state.loadingSubmitAnswers == ResponseValidation.LOADING) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Memproses hasil tes...',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            );
          }

          // Error state
          if (state.statusSubmitAnswers == ResponseValidation.FAIL) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50.sp, color: Colors.red),
                  SizedBox(height: 2.h),
                  Text(
                    'Gagal memuat hasil tes',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    state.messageSubmitAnswers ?? 'Terjadi kesalahan',
                    style: TextStyle(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3.h),
                  ElevatedButton(
                    onPressed: () {
                      RouterNavigation.router.push(PAGESNAMES.home.ScreenPath);
                    },
                    child: Text('Kembali ke Beranda'),
                  ),
                ],
              ),
            );
          }

          // Success state - tampilkan hasil
          if (state.statusSubmitAnswers == ResponseValidation.SUCCESS && 
              state.dataSubmitAnswers != null) {
            return _buildResultContent(state.dataSubmitAnswers!);
          }

          // Default state - loading atau data belum tersedia
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Memuat hasil tes...',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultContent(dynamic dataSubmitAnswers) {
    return SingleChildScrollView(
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
            
            // Results Cards - Dynamic dari API
            ...dataSubmitAnswers.data.scores.map<Widget>((score) {
              final category = _getCategoryFromScore(score);
              return Column(
                children: [
                  _buildResultCard(
                    score.domain,
                    score.category,
                    category.color,
                    category.description,
                    "${score.rawScore} (${score.finalScore})",
                  ),
                  SizedBox(height: 2.h),
                ],
              );
            }).toList(),
            
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

  // Fungsi untuk menentukan kategori berdasarkan skor DASS-21
  CategoryInfo _getCategoryFromScore(dynamic score) {
    final finalScore = score.finalScore;
    final domain = score.domain;
    
    // Kriteria DASS-21 untuk kategori berdasarkan final score
    if (domain == "Depresi") {
      return _getDepressionCategory(finalScore);
    } else if (domain == "Kecemasan") {
      return _getAnxietyCategory(finalScore);
    } else if (domain == "Stres") {
      return _getStressCategory(finalScore);
    }
    
    // Default category
    return CategoryInfo(
      color: Colors.grey,
      description: "Skor Anda menunjukkan tingkat $domain.",
    );
  }

  CategoryInfo _getDepressionCategory(int finalScore) {
    if (finalScore <= 9) {
      return CategoryInfo(
        color: Colors.green,
        description: "Skor Anda menunjukkan tingkat depresi yang normal. Anda tidak menunjukkan tanda-tanda depresi yang signifikan.",
      );
    } else if (finalScore <= 13) {
      return CategoryInfo(
        color: Colors.orange,
        description: "Skor Anda menunjukkan tingkat depresi ringan. Pertimbangkan untuk melakukan aktivitas yang menyenangkan dan menjaga rutinitas yang sehat.",
      );
    } else if (finalScore <= 20) {
      return CategoryInfo(
        color: Colors.red,
        description: "Skor Anda menunjukkan tingkat depresi sedang. Disarankan untuk berkonsultasi dengan profesional kesehatan mental.",
      );
    } else if (finalScore <= 27) {
      return CategoryInfo(
        color: Colors.purple,
        description: "Skor Anda menunjukkan tingkat depresi parah. Sangat disarankan untuk segera berkonsultasi dengan profesional kesehatan mental.",
      );
    } else {
      return CategoryInfo(
        color: Colors.red[900]!,
        description: "Skor Anda menunjukkan tingkat depresi yang sangat parah. Segera cari bantuan profesional kesehatan mental.",
      );
    }
  }

  CategoryInfo _getAnxietyCategory(int finalScore) {
    if (finalScore <= 7) {
      return CategoryInfo(
        color: Colors.green,
        description: "Skor Anda menunjukkan tingkat kecemasan yang normal. Anda dapat mengelola kecemasan dengan baik.",
      );
    } else if (finalScore <= 9) {
      return CategoryInfo(
        color: Colors.orange,
        description: "Skor Anda menunjukkan tingkat kecemasan ringan. Pertimbangkan untuk melakukan relaksasi dan teknik manajemen stres.",
      );
    } else if (finalScore <= 14) {
      return CategoryInfo(
        color: Colors.red,
        description: "Skor Anda menunjukkan tingkat kecemasan sedang. Disarankan untuk berkonsultasi dengan profesional kesehatan mental.",
      );
    } else if (finalScore <= 19) {
      return CategoryInfo(
        color: Colors.purple,
        description: "Skor Anda menunjukkan tingkat kecemasan parah. Sangat disarankan untuk segera berkonsultasi dengan profesional kesehatan mental.",
      );
    } else {
      return CategoryInfo(
        color: Colors.red[900]!,
        description: "Skor Anda menunjukkan tingkat kecemasan yang sangat parah. Segera cari bantuan profesional kesehatan mental.",
      );
    }
  }

  CategoryInfo _getStressCategory(int finalScore) {
    if (finalScore <= 14) {
      return CategoryInfo(
        color: Colors.green,
        description: "Skor Anda menunjukkan tingkat stres yang normal. Anda dapat mengelola stres dengan baik dalam kehidupan sehari-hari.",
      );
    } else if (finalScore <= 18) {
      return CategoryInfo(
        color: Colors.orange,
        description: "Skor Anda menunjukkan tingkat stres ringan. Pertimbangkan untuk melakukan teknik relaksasi dan manajemen waktu.",
      );
    } else if (finalScore <= 25) {
      return CategoryInfo(
        color: Colors.red,
        description: "Skor Anda menunjukkan tingkat stres sedang. Disarankan untuk berkonsultasi dengan profesional kesehatan mental.",
      );
    } else if (finalScore <= 33) {
      return CategoryInfo(
        color: Colors.purple,
        description: "Skor Anda menunjukkan tingkat stres parah. Sangat disarankan untuk segera berkonsultasi dengan profesional kesehatan mental.",
      );
    } else {
      return CategoryInfo(
        color: Colors.red[900]!,
        description: "Skor Anda menunjukkan tingkat stres yang sangat parah. Segera cari bantuan profesional kesehatan mental.",
      );
    }
  }
}

// Class untuk menyimpan informasi kategori
class CategoryInfo {
  final Color color;
  final String description;

  CategoryInfo({
    required this.color,
    required this.description,
  });
}
