import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_event.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_state.dart';
import 'package:healmeumpapp/features/home/presentation/widget/shimmer_home_page.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/global/widget/logout_dialog.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _bloc;
  late Future<String> username;
  late Future<String> faculty;
  late Future<String> name;
  late Future<String> studyProgram;
  late Future<String> type;
  late Future<String> hp;
  late Future<String> email;

  @override
  void initState() {
    type = LocalDataSource().getType();
    username = LocalDataSource().getUsername();
    faculty = LocalDataSource().getFaculty();
    studyProgram = LocalDataSource().getStudyProgram();
    name = LocalDataSource().getName();
    hp = LocalDataSource().getPhoneNumber();
    email = LocalDataSource().getEmail();
    super.initState();
    _bloc = context.read<HomeBloc>();
    _getVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userId = await username;
      final userType = await type;
      const questionnaireCode = 'DASS21';
      const limit = '10';
      
      if (userType == "2") {
        // Admin: Load admin data
        _bloc.add(GetScoreAdminHistoryEvent(limit: limit));
        _bloc.add(GetExportAdminHistoryEvent(
          includeEncryptedData: false,
          format: 'json',
          questionnaireCode: '',
        ));
      } else {
        // User: Load user data
        await _getScoreHistoryWithType(userId, questionnaireCode, limit);
      }
    });
  }

  _getVersion() async {
    _bloc.add(GetVersionEvent());
  }

  // Get score history with type local datasource
  Future<void> _getScoreHistoryWithType(String userId, String questionnaireCode, String limit) async {
    final userType = (await type).trim(); // type: Future<String>
    if (userType == "1") {
      _bloc.add(GetScoreHistoryEvent(userId: userId, questionnaireCode: questionnaireCode));
    } else {
      _bloc.add(GetScoreAdminHistoryEvent(limit: limit));
    }
  }

  void _showComingSoonDialog(String testName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: cPrimary,
                size: 24.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimary,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$testName akan segera hadir!',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cPrimaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Fitur ini sedang dalam pengembangan dan akan segera tersedia untuk Anda.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: cPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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

  void _showDass21RequiredDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[600],
                size: 24.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Tes DASS21 Diperlukan',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[600],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Anda harus menyelesaikan Tes Kesehatan Mental (DASS21) terlebih dahulu sebelum dapat mengakses Tes Depresi.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cPrimaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Silakan lakukan Tes Kesehatan Mental terlebih dahulu.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Mengerti',
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

  Color _getScoreColor(String category) {
    switch (category.toLowerCase()) {
      case 'tidak depresi':
      case 'normal':
      case 'ringan':
        return Colors.green[600]!;
      case 'sedang':
      case 'berisiko':
        return Colors.orange[600]!;
      case 'berat':
      case 'sangat berat':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _getScoreIcon(String questionnaireCode) {
    switch (questionnaireCode) {
      case 'DASS21':
        return Icons.psychology;
      case 'BDI2':
        return Icons.favorite;
      default:
        return Icons.quiz;
    }
  }

  String _getTestName(String questionnaireCode) {
    switch (questionnaireCode) {
      case 'DASS21':
        return 'Tes Kesehatan Mental';
      case 'BDI2':
        return 'Tes Depresi';
      default:
        return 'Tes Lainnya';
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 minggu yang lalu' : '$weeks minggu yang lalu';
    } else {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 bulan yang lalu' : '$months bulan yang lalu';
    }
  }

  // Admin helper methods
  String _getQuestionnaireName(String code) {
    switch (code) {
      case 'DASS21':
        return 'Tes Kesehatan Mental';
      case 'BDI2':
        return 'Tes Depresi';
      case 'BAI':
        return 'Tes Kecemasan';
      case 'PSS10':
        return 'Tes Stres';
      default:
        return 'Tes Lainnya';
    }
  }

  IconData _getQuestionnaireIcon(String code) {
    switch (code) {
      case 'DASS21':
        return Icons.psychology;
      case 'BDI2':
        return Icons.favorite;
      case 'BAI':
        return Icons.flash_on;
      case 'PSS10':
        return Icons.trending_up;
      default:
        return Icons.quiz;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'tidak depresi':
      case 'tidak cemas':
      case 'tidak stres':
      case 'normal':
      case 'ringan':
      case 'minimal':
      case 'rendah':
        return Colors.green[600]!;
      case 'sedang':
      case 'berisiko':
        return Colors.orange[600]!;
      case 'berat':
      case 'sangat berat':
      case 'depresi':
      case 'cemas':
      case 'stres':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.download,
                color: cPrimary,
                size: 24.sp,
              ),
              SizedBox(width: 2.w),
              Text(
                'Export Data',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimary,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Data berhasil diekspor dalam format JSON',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: cPrimaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: cBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cPrimary.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Format: JSON',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: cPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Total Records: ${_bloc.state.dataExportAdminHistory?.dataExport.summary.totalRecords ?? 0}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: cPrimaryText,
                      ),
                    ),
                    Text(
                      'Export Date: ${_bloc.state.dataExportAdminHistory?.dataExport.summary.exportDate ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: cPrimaryText,
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
              style: TextButton.styleFrom(
                backgroundColor: cPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
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
                                child: FutureBuilder<String>(
                                    future: name,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        String initials = snapshot.data!
                                                .trim()
                                                .isNotEmpty
                                            ? snapshot.data![0].toUpperCase()
                                            : 'N';
                                        return Text(initials,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: cPrimary));
                                      } else {
                                        return Text("N",
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: cPrimary));
                                      }
                                    })),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                  future: name,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          snapshot.data ?? 'Nama Pengguna',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white));
                                    } else {
                                      return Text("Nama Pengguna",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white));
                                    }
                                  }),
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
                                onLogout: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  await pref.clear();
                                  context.go(PAGESNAMES.login.ScreenPath);

                                  print('User logged out');
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
                                  FutureBuilder<String>(
                                    future: username,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "1234567890",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  FutureBuilder<String>(
                                    future: type,
                                    builder: (context, typeSnapshot) {
                                      return Text(
                                        typeSnapshot.data == "1"
                                            ? "Jurusan"
                                            : "Fakultas",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  Spacer(),
                                  FutureBuilder<String>(
                                    future: type,
                                    builder: (context, typeSnapshot) {
                                      if (typeSnapshot.data == "1") {
                                        // Mahasiswa - tampilkan studyProgram
                                        return FutureBuilder<String>(
                                          future: studyProgram,
                                          builder: (context, snapshot) {
                                            return Text(
                                              snapshot.data ?? "PROGRAM STUDI",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        // Dosen - tampilkan faculty
                                        return FutureBuilder<String>(
                                          future: faculty,
                                          builder: (context, snapshot) {
                                            return Text(
                                              snapshot.data ??
                                                  "FAKULTAS ILMU KESEHATAN",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.loadingVersion == ResponseValidation.LOADING) {
                    return ShimmerHomePage();
                  }

                  if (state.statusVersion == ResponseValidation.SUCCESS) {
                    return FutureBuilder<String>(
                      future: type,
                      builder: (context, typeSnapshot) {
                        if (typeSnapshot.data == "2") {
                          // Admin Dashboard
                          return _buildAdminDashboard(state);
                        } else {
                          // User Dashboard
                          return _buildUserDashboard(state);
                        }
                      },
                    );
                  }

                  if (state.statusVersion == ResponseValidation.FAIL) {
                    return Center(
                      child: Text(
                        state.messageVersion ?? 'Gagal memuat data versi.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDashboard(HomeState state) {
    return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 5.w,
                          top: 3.h,
                        ),
                        child: Container(
                          height: 54.h,
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
                            padding: EdgeInsets.only(
                                left: 5.w, right: 2.w, top: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pilih tes yang ingin Anda lakukan",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 3.h),
                                GestureDetector(
                                  onTap: () async {
                                    final extra = {
                                      'questionnaireCode': 'DASS21',
                                      'userId': await username,
                                      'namaPegawai': await name,
                                      'nip': await username,
                                      'jenisPegawai': await type == "1" ? "MAHASISWA" : "DOSEN",
                                      'prodi': await studyProgram,
                                      'email': await email,
                                      'hp': await hp,
                                    };
                                    RouterNavigation.router.push(
                                        PAGESNAMES.mentalHealth.ScreenPath,
                                        extra: extra);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: cBackground2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/icon-brain-dashboard.png'),
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        height: 8.h,
                                        width: 50.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize: 12.sp,
                                                  color: cPrimaryText),
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
                                  onTap: () async {
                                    // Check if DASS21 has been completed
                                    if (state.dataScoreHistory?.dataScore.scores.any((score) => score.questionnaireCode == 'DASS21') != true) {
                                      _showDass21RequiredDialog();
                                      return;
                                    }
                                    
                                    final extra = {
                                      'questionnaireCode': 'BDI2',
                                      'userId': await username,
                                      'namaPegawai': await name,
                                      'nip': await username,
                                      'jenisPegawai': await type == "1" ? "MAHASISWA" : "DOSEN",
                                      'prodi': await studyProgram,
                                      'email': await email,
                                      'hp': await hp,
                                    };
                                    RouterNavigation.router.push(
                                        PAGESNAMES.depression.ScreenPath,
                                        extra: extra);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAEBEE),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/icon-favorite-dashboard.png'),
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        height: 8.h,
                                        width: 50.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize: 12.sp,
                                                  color: cPrimaryText),
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
                                    _showComingSoonDialog("Tes Kecemasan");
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFDF2DB),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/icon-flash-on-dashboard.png'),
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        height: 8.h,
                                        width: 50.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize: 12.sp,
                                                  color: cPrimaryText),
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
                                    _showComingSoonDialog("Tes Stres");
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEE9FE),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(
                                            'assets/icon-pulse-dashboard.png'),
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        height: 8.h,
                                        width: 50.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize: 12.sp,
                                                  color: cPrimaryText),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Riwayat Tes',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: cPrimaryText,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        RouterNavigation.router.push(PAGESNAMES.history.ScreenPath);
                                      },
                                      child: Text(
                                        'Lihat Semua',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: cPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),

                                // Test History Items
                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    if (state.loadingScoreHistory == ResponseValidation.LOADING) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                                        ),
                                      );
                                    }

                                    if (state.dataScoreHistory?.dataScore.scores.isEmpty ?? true) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 4.h),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.quiz_outlined,
                                              size: 48.sp,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              'Belum ada riwayat tes',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text(
                                              'Mulai lakukan tes untuk melihat riwayat',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: state.dataScoreHistory!.dataScore.scores.take(2).map((score) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 1.5.h),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.h, horizontal: 3.w),
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
                                                  color: _getScoreColor(score.category).withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  _getScoreIcon(score.questionnaireCode),
                                                  color: _getScoreColor(score.category),
                                                  size: 20.sp,
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _getTestName(score.questionnaireCode),
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: cPrimaryText,
                                                      ),
                                                    ),
                                                    SizedBox(height: 0.5.h),
                                                    // Text(
                                                    //   'Kategori: ${score.category}',
                                                    //   style: TextStyle(
                                                    //     fontSize: 12.sp,
                                                    //     color: _getScoreColor(score.category),
                                                    //     fontWeight: FontWeight.w500,
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: 0.5.h),
                                                    Text(
                                                      _formatDate(score.submittedAt),
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
                                        );
                                      }).toList(),
                                    );
                                  },
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
                                    RouterNavigation.router
                                        .push(PAGESNAMES.about.ScreenPath);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2.w),
                                          decoration: BoxDecoration(
                                            color:
                                                cPrimary.withValues(alpha: 0.1),
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
                                    RouterNavigation.router
                                        .push(PAGESNAMES.support.ScreenPath);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2.w),
                                          decoration: BoxDecoration(
                                            color:
                                                cPrimary.withValues(alpha: 0.1),
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
                  );
  }

  Widget _buildAdminDashboard(HomeState state) {
    // Check if admin data is loading
    if (state.loadingScoreAdminHistory == ResponseValidation.LOADING) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
        ),
      );
    }

    // Check if admin data failed to load
    if (state.statusScoreAdminHistory == ResponseValidation.FAIL) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: Colors.red[400],
            ),
            SizedBox(height: 2.h),
            Text(
              state.messageScoreAdminHistory ?? 'Gagal memuat data admin.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Statistics Cards
        Padding(
          padding: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
            top: 3.h,
          ),
          child: Column(
            children: [
              // Second row - Category breakdown
              _buildCategorySummaryCards(state),
            ],
          ),
        ),
        
        // Export Data Card
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Export Data',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _bloc.add(GetExportAdminHistoryEvent(
                            includeEncryptedData: false,
                            format: 'json',
                            questionnaireCode: '',
                          ));
                          _showExportDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: cPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Export JSON',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  if (state.dataExportAdminHistory != null) ...[
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: cBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: cPrimary.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data Export Terbaru',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: cPrimaryText,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Total Records: ${state.dataExportAdminHistory!.dataExport.summary.totalRecords}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: cPrimaryText,
                            ),
                          ),
                          Text(
                            'Format: ${state.dataExportAdminHistory!.dataExport.format.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: cPrimaryText,
                            ),
                          ),
                          Text(
                            'Export Date: ${state.dataExportAdminHistory!.dataExport.summary.exportDate}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: cPrimaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Text(
                      'Klik Export JSON untuk mendapatkan data terbaru',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // Recent Test Results
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Tes Terbaru',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          RouterNavigation.router.push(PAGESNAMES.history.ScreenPath);
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: cPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Test History Items
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.loadingScoreAdminHistory == ResponseValidation.LOADING) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                          ),
                        );
                      }

                      if (state.dataScoreAdminHistory?.dataScore.scores.isEmpty ?? true) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Column(
                            children: [
                              Icon(
                                Icons.quiz_outlined,
                                size: 48.sp,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Belum ada riwayat tes',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: state.dataScoreAdminHistory!.dataScore.scores.take(5).map((score) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 1.5.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.w),
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
                                    color: _getCategoryColor(score.category).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    _getQuestionnaireIcon(score.questionnaireCode),
                                    color: _getCategoryColor(score.category),
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getQuestionnaireName(score.questionnaireCode),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: cPrimaryText,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        'Domain: ${score.domain}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        _formatDate(score.submittedAt),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(score.category).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    score.category,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: _getCategoryColor(score.category),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }


  Widget _buildCategorySummaryCards(HomeState state) {
    // Analyze scores directly to create category breakdown
    final scores = state.dataScoreAdminHistory?.dataScore.scores ?? [];
    
    if (scores.isEmpty) {
      return SizedBox.shrink();
    }

    // Count each category from scores
    final categoryCounts = <String, int>{};
    for (final score in scores) {
      categoryCounts[score.category] = (categoryCounts[score.category] ?? 0) + 1;
    }

    return Column(
      children: [
        // All categories display
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distribusi Kategori',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
              SizedBox(height: 2.h),
              Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                children: categoryCounts.entries.map((entry) {
                  final category = entry.key;
                  final count = entry.value;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getCategoryColor(category).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getCategoryIcon(category),
                          size: 14.sp,
                          color: _getCategoryColor(category),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '$category: $count',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: _getCategoryColor(category),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        // Summary questionnaires display
        _buildSummaryQuestionnaires(state),
        SizedBox(height: 2.h),
        // Summary categories display
        _buildSummaryCategories(state),
        SizedBox(height: 2.h),
        // Questionnaire breakdown
        // _buildQuestionnaireBreakdown(state),
        // SizedBox(height: 2.h),
        // Detailed questionnaires display
        _buildDetailedQuestionnaires(state),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'tidak depresi':
      case 'tidak cemas':
      case 'tidak stres':
      case 'normal':
      case 'minimal':
      case 'rendah':
        return Icons.check_circle;
      case 'sedang':
      case 'berisiko':
        return Icons.warning;
      case 'berat':
      case 'sangat berat':
      case 'depresi':
      case 'cemas':
      case 'stres':
        return Icons.error;
      default:
        return Icons.info;
    }
  }


  Widget _buildSummaryQuestionnaires(HomeState state) {
    final summary = state.dataScoreAdminHistory?.dataScore.summary;
    final scores = state.dataScoreAdminHistory?.dataScore.scores ?? [];
    
    // Debug print
    print('DEBUG: dataScoreAdminHistory: ${state.dataScoreAdminHistory != null}');
    print('DEBUG: summary: ${summary != null}');
    print('DEBUG: scores length: ${scores.length}');
    print('DEBUG: totalResponses: ${summary?.totalResponses}');
    
    if (summary == null || scores.isEmpty) {
      print('DEBUG: Returning empty widget - summary: ${summary != null}, scores: ${scores.length}');
      return SizedBox.shrink();
    }

    // Use questionnaires from summary API response
    final questionnaires = summary.questionnaireItems ?? [];
    final totalScores = summary.totalScores ?? summary.totalResponses;
    
    print('DEBUG: questionnaires from API: $questionnaires');
    print('DEBUG: totalScores from API: $totalScores');
    
    // Prevent division by zero
    if (totalScores <= 0) {
      print('DEBUG: totalScores is $totalScores, returning empty widget');
      return SizedBox.shrink();
    }
    
    print('DEBUG: Using scores.length as totalScores: $totalScores');

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Summary Questionnaires',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: cPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: $totalScores',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: cPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Questionnaire summary cards
          Row(
            children: questionnaires.map((questionnaire) {
              final code = questionnaire.code;
              final count = questionnaire.count;
              final percentage = totalScores > 0 ? ((count / totalScores) * 100).round() : 0;
              
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: _getQuestionnaireColor(code).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getQuestionnaireColor(code).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _getQuestionnaireIcon(code),
                        size: 24.sp,
                        color: _getQuestionnaireColor(code),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _getQuestionnaireName(code),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '$count',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: _getQuestionnaireColor(code),
                        ),
                      ),
                      Text(
                        '($percentage%)',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 2.h),
          // Progress bars
          Column(
            children: questionnaires.map((questionnaire) {
              final code = questionnaire.code;
              final count = questionnaire.count;
              final percentage = totalScores > 0 ? (count / totalScores).clamp(0.0, 1.0) : 0.0;
              
              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getQuestionnaireName(code),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: cPrimaryText,
                          ),
                        ),
                        Text(
                          '$count (${(percentage * 100).round()}%)',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Container(
                      height: 0.8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[200],
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _getQuestionnaireColor(code),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCategories(HomeState state) {
    final summary = state.dataScoreAdminHistory?.dataScore.summary;
    final scores = state.dataScoreAdminHistory?.dataScore.scores ?? [];
    
    // Debug print
    print('DEBUG CATEGORIES: dataScoreAdminHistory: ${state.dataScoreAdminHistory != null}');
    print('DEBUG CATEGORIES: summary: ${summary != null}');
    print('DEBUG CATEGORIES: scores length: ${scores.length}');
    print('DEBUG CATEGORIES: totalResponses: ${summary?.totalResponses}');
    
    if (summary == null || scores.isEmpty) {
      print('DEBUG CATEGORIES: Returning empty widget - summary: ${summary != null}, scores: ${scores.length}');
      return SizedBox.shrink();
    }

    // Count categories from scores data
    final categoryCounts = <String, int>{};
    for (final score in scores) {
      categoryCounts[score.category] = (categoryCounts[score.category] ?? 0) + 1;
    }
    
    print('DEBUG CATEGORIES: categoryCounts: $categoryCounts');
    
    // Use scores.length instead of totalResponses which might be 0
    final totalScores = scores.length;
    
    // Prevent division by zero
    if (totalScores <= 0) {
      print('DEBUG CATEGORIES: totalScores is $totalScores, returning empty widget');
      return SizedBox.shrink();
    }
    
    print('DEBUG CATEGORIES: Using scores.length as totalScores: $totalScores');

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Summary Categories',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryText,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: cPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: $totalScores',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: cPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Categories grid
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: categoryCounts.entries.map((entry) {
              final categoryName = entry.key;
              final count = entry.value;
              final percentage = totalScores > 0 ? ((count / totalScores) * 100).round() : 0;
              
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: _getCategoryColor(categoryName).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _getCategoryColor(categoryName).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(categoryName),
                      size: 14.sp,
                      color: _getCategoryColor(categoryName),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '$categoryName: $count ($percentage%)',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: _getCategoryColor(categoryName),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 2.h),
          // Categories progress bars
          Column(
            children: categoryCounts.entries.map((entry) {
              final categoryName = entry.key;
              final count = entry.value;
              final percentage = totalScores > 0 ? (count / totalScores).clamp(0.0, 1.0) : 0.0;
              
              return Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: cPrimaryText,
                          ),
                        ),
                        Text(
                          '$count (${(percentage * 100).round()}%)',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Container(
                      height: 0.8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[200],
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _getCategoryColor(categoryName),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedQuestionnaires(HomeState state) {
    final scores = state.dataScoreAdminHistory?.dataScore.scores ?? [];
    
    if (scores.isEmpty) {
      return SizedBox.shrink();
    }

    // Group scores by questionnaire
    final questionnaireGroups = <String, List<dynamic>>{};
    for (final score in scores) {
      if (!questionnaireGroups.containsKey(score.questionnaireCode)) {
        questionnaireGroups[score.questionnaireCode] = [];
      }
      questionnaireGroups[score.questionnaireCode]!.add(score);
    }

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Jenis Tes',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: cPrimaryText,
            ),
          ),
          SizedBox(height: 2.h),
          ...questionnaireGroups.entries.map((entry) {
            final code = entry.key;
            final questionnaireScores = entry.value;
            final totalCount = questionnaireScores.length;
            
            // Count domains for this questionnaire
            final domainCounts = <String, int>{};
            for (final score in questionnaireScores) {
              domainCounts[score.domain] = (domainCounts[score.domain] ?? 0) + 1;
            }

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: _getQuestionnaireColor(code).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getQuestionnaireColor(code).withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Questionnaire header
                  Row(
                    children: [
                      Icon(
                        _getQuestionnaireIcon(code),
                        size: 20.sp,
                        color: _getQuestionnaireColor(code),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          _getQuestionnaireName(code),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: cPrimaryText,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getQuestionnaireColor(code),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Total: $totalCount',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // Domain breakdown
                  Wrap(
                    spacing: 1.w,
                    runSpacing: 0.5.h,
                    children: domainCounts.entries.map((domainEntry) {
                      final domain = domainEntry.key;
                      final count = domainEntry.value;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getQuestionnaireColor(code).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$domain: $count',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: _getQuestionnaireColor(code),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getQuestionnaireColor(String code) {
    switch (code) {
      case 'DASS21':
        return Colors.blue;
      case 'BDI2':
        return Colors.pink;
      case 'BAI':
        return Colors.orange;
      case 'PSS10':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
