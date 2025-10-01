import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';
import 'package:sizer/sizer.dart';

class MentalHealthResultPage extends StatefulWidget {
  const MentalHealthResultPage({super.key});

  @override
  State<MentalHealthResultPage> createState() => _MentalHealthResultPageState();
}

class _MentalHealthResultPageState extends State<MentalHealthResultPage> {
  bool _hasShownDepressionDialog = false;
  bool _isCheckingDepression = false;

  @override
  void initState() {
    super.initState();
    // Reset flags when page is initialized
    _hasShownDepressionDialog = false;
    _isCheckingDepression = false;
    
    // Check for depression result after a short delay to ensure UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDepressionResult();
    });
  }

  @override
  void dispose() {
    // Reset flags when page is disposed
    _hasShownDepressionDialog = false;
    _isCheckingDepression = false;
    super.dispose();
  }

  void _checkDepressionResult() {
    // This will be called after the result content is built
    // We'll check the depression result in _buildResultContent
  }

  void _checkDepressionResultAndShowDialog(dynamic dataSubmitAnswers) {
    // Prevent multiple checks and dialog appearances
    if (_isCheckingDepression || _hasShownDepressionDialog) {
      print('DEBUG: Skipping depression check - already checked or dialog shown');
      return;
    }

    print('DEBUG: _checkDepressionResultAndShowDialog called');
    print('DEBUG: dataSubmitAnswers: ${dataSubmitAnswers != null}');
    print('DEBUG: dataSubmitAnswers.data: ${dataSubmitAnswers?.data != null}');
    print('DEBUG: dataSubmitAnswers.data.scores: ${dataSubmitAnswers?.data?.scores != null}');
    
    if (dataSubmitAnswers?.data?.scores != null) {
      _isCheckingDepression = true;
      print('DEBUG: scores length: ${dataSubmitAnswers.data.scores.length}');
      
      try {
        // Find depression score using loop instead of firstWhere to avoid type issues
        dynamic depressionScore;
        for (final score in dataSubmitAnswers.data.scores) {
          print('DEBUG: checking score domain: ${score.domain}');
          if (score.domain == "Depresi") {
            depressionScore = score;
            break;
          }
        }

        if (depressionScore != null) {
          final finalScore = depressionScore.finalScore ?? 0;
          print('DEBUG: depression finalScore: $finalScore');
          
          final depressionCategory = _getDepressionCategory(finalScore);
          print('DEBUG: depression category color: ${depressionCategory.color}');
          
          // Check if depression category is not normal (ringan, sedang, parah, sangat parah)
          if (finalScore > 9 && !_hasShownDepressionDialog) {
            print('DEBUG: Final score > 9, showing dialog');
            _hasShownDepressionDialog = true;
            
            // Show dialog after a short delay to ensure UI is ready
            Future.delayed(Duration(milliseconds: 500), () {
              if (mounted && _hasShownDepressionDialog) {
                print('DEBUG: Showing depression dialog');
                _showDepressionTestDialog(depressionCategory);
              }
            });
          } else {
            print('DEBUG: Final score <= 9 or dialog already shown, not showing dialog');
          }
        } else {
          print('DEBUG: No depression score found');
        }
      } catch (e) {
        print('Error in _checkDepressionResultAndShowDialog: $e');
        // Fallback: try to find depression score using different approach
        try {
          for (final score in dataSubmitAnswers.data.scores) {
            if (score.domain == "Depresi") {
              final finalScore = score.finalScore ?? 0;
              final depressionCategory = _getDepressionCategory(finalScore);
              
              if (finalScore > 9 && !_hasShownDepressionDialog) {
                _hasShownDepressionDialog = true;
                Future.delayed(Duration(milliseconds: 500), () {
                  if (mounted && _hasShownDepressionDialog) {
                    _showDepressionTestDialog(depressionCategory);
                  }
                });
              }
              break;
            }
          }
        } catch (fallbackError) {
          print('Fallback error: $fallbackError');
        }
      } finally {
        _isCheckingDepression = false;
      }
    } else {
      print('DEBUG: dataSubmitAnswers or scores is null');
    }
  }

  void _showDepressionTestDialog(CategoryInfo depressionCategory) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.psychology,
                color: depressionCategory.color,
                size: 24.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Tes Depresi Disarankan',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: depressionCategory.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: depressionCategory.color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori Depresi Anda:',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: cPrimaryText,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      _getDepressionCategoryName(depressionCategory.color),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: depressionCategory.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Berdasarkan hasil tes kesehatan mental Anda, kami mendeteksi adanya indikasi depresi yang memerlukan evaluasi lebih lanjut.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cPrimaryText,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Kami menyarankan Anda untuk melakukan tes depresi (BDI-2) untuk mendapatkan penilaian yang lebih spesifik dan akurat.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cPrimaryText,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: depressionCategory.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: depressionCategory.color,
                      size: 20.sp,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'Tes depresi akan memberikan analisis yang lebih detail tentang kondisi mental Anda.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: depressionCategory.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Nanti Saja',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToDepressionTest();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: depressionCategory.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              ),
              child: Text(
                'Lakukan Tes Depresi',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDepressionTest() async {
    try {
      // Get user data from local storage
      final username = await LocalDataSource().getUsername();
      final name = await LocalDataSource().getName();
      final type = await LocalDataSource().getType();
      final studyProgram = await LocalDataSource().getStudyProgram();
      final email = await LocalDataSource().getEmail();
      final hp = await LocalDataSource().getPhoneNumber();
      
      // Prepare extra parameters for depression page
      final extra = {
        'questionnaireCode': 'BDI2',
        'userId': username,
        'namaPegawai': name,
        'nip': username,
        'jenisPegawai': type == "1" ? "MAHASISWA" : "DOSEN",
        'prodi': studyProgram,
        'email': email,
        'hp': hp,
      };
      
      print('DEBUG: Navigating to depression page with extra: $extra');
      
      // Navigate to depression test with proper parameters using go instead of push
      // This prevents user from going back to mental health test
      RouterNavigation.router.go(
        PAGESNAMES.depression.ScreenPath,
        extra: extra,
      );
    } catch (e) {
      print('Error in _navigateToDepressionTest: $e');
      // Fallback navigation without extra parameters
      RouterNavigation.router.go(PAGESNAMES.depression.ScreenPath);
    }
  }

  // Method untuk mendapatkan nama kategori depresi berdasarkan warna
  String _getDepressionCategoryName(Color color) {
    if (color == Colors.green) {
      return 'Normal';
    } else if (color == Colors.orange) {
      return 'Ringan';
    } else if (color == Colors.red) {
      return 'Sedang';
    } else if (color == Colors.purple) {
      return 'Parah';
    } else if (color == Colors.red[900]) {
      return 'Sangat Parah';
    } else {
      return 'Tidak Diketahui';
    }
  }

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
                  SizedBox(height: 3.h),
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
    // Check for depression result and show dialog if needed
    // Only check once when data is loaded and dialog hasn't been shown
    if (!_hasShownDepressionDialog && !_isCheckingDepression) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkDepressionResultAndShowDialog(dataSubmitAnswers);
      });
    }

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
                    SizedBox(height: 2.h),
                    
                    // Total Score Section
                    if (dataSubmitAnswers.data != null && dataSubmitAnswers.data.scores.isNotEmpty)
                      _buildTotalScoreSection(dataSubmitAnswers.data.scores),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 3.h),
            
            // Results Cards - Dynamic dari API
            if (dataSubmitAnswers.data != null && dataSubmitAnswers.data.scores.isNotEmpty)
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
              }).toList()
            else
              // Fallback jika data tidak tersedia
              Container(
                width: sWidthFull(context),
                padding: EdgeInsets.all(4.w),
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
                child: Column(
                  children: [
                    Icon(Icons.info_outline, size: 8.w, color: Colors.orange),
                    SizedBox(height: 2.h),
                    Text(
                      "Data hasil tes tidak tersedia",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: cPrimaryText,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      "Silakan coba lagi atau hubungi administrator.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            
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
            
            // Action Button - Kembali ke Beranda
            GestureDetector(
              onTap: () {
                RouterNavigation.router.push(PAGESNAMES.home.ScreenPath);
              },
              child: Container(
                width: sWidthFull(context),
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
    // Null safety check
    if (score == null) {
      return CategoryInfo(
        color: Colors.grey,
        description: "Data skor tidak tersedia.",
      );
    }
    
    final finalScore = score.finalScore ?? 0;
    final domain = score.domain ?? "Unknown";
    
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

  // Method untuk membangun section total skor
  Widget _buildTotalScoreSection(List scores) {
    final totalScoreInfo = _calculateTotalScore(scores);
    
    return Container(
      width: sWidthFull(context),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: totalScoreInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: totalScoreInfo.color.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.analytics,
                color: totalScoreInfo.color,
                size: 20.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Total Skor',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            '${totalScoreInfo.totalScore}',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: totalScoreInfo.color,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Kategori: ${totalScoreInfo.category}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: totalScoreInfo.color,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            totalScoreInfo.description,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Method untuk menghitung total skor
  TotalScoreInfo _calculateTotalScore(List scores) {
    num totalScore = 0;
    
    // Hitung total skor berdasarkan formula: (Depresi x 2) + (Kecemasan x 2) + (Stres x 2)
    for (final score in scores) {
      totalScore += score.finalScore ?? 0;
    }
    
    return _getTotalScoreCategory(totalScore.toInt());
  }

  // Method untuk menentukan kategori berdasarkan total skor
  TotalScoreInfo _getTotalScoreCategory(int totalScore) {
    if (totalScore >= 0 && totalScore <= 30) {
      return TotalScoreInfo(
        totalScore: totalScore,
        category: 'Normal',
        color: Colors.green,
        description: 'Skor total Anda menunjukkan kondisi kesehatan mental yang normal. Pertahankan pola hidup sehat dan seimbang.',
      );
    } else if (totalScore >= 31 && totalScore <= 50) {
      return TotalScoreInfo(
        totalScore: totalScore,
        category: 'Ringan',
        color: Colors.orange,
        description: 'Skor total Anda menunjukkan kondisi kesehatan mental ringan. Pertimbangkan untuk melakukan aktivitas relaksasi dan manajemen stres.',
      );
    } else if (totalScore >= 51 && totalScore <= 70) {
      return TotalScoreInfo(
        totalScore: totalScore,
        category: 'Sedang',
        color: Colors.red,
        description: 'Skor total Anda menunjukkan kondisi kesehatan mental sedang. Disarankan untuk berkonsultasi dengan profesional kesehatan mental.',
      );
    } else if (totalScore >= 71 && totalScore <= 90) {
      return TotalScoreInfo(
        totalScore: totalScore,
        category: 'Parah',
        color: Colors.purple,
        description: 'Skor total Anda menunjukkan kondisi kesehatan mental parah. Sangat disarankan untuk segera berkonsultasi dengan profesional kesehatan mental.',
      );
    } else {
      return TotalScoreInfo(
        totalScore: totalScore,
        category: 'Sangat Parah',
        color: Colors.red[900]!,
        description: 'Skor total Anda menunjukkan kondisi kesehatan mental yang sangat parah. Segera cari bantuan profesional kesehatan mental.',
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

// Class untuk menyimpan informasi total skor
class TotalScoreInfo {
  final int totalScore;
  final String category;
  final Color color;
  final String description;

  TotalScoreInfo({
    required this.totalScore,
    required this.category,
    required this.color,
    required this.description,
  });
}
