import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/data/model/mental_health_model.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class MentalHealthPage extends StatefulWidget {
  const MentalHealthPage({super.key});

  @override
  State<MentalHealthPage> createState() => _MentalHealthPageState();
}

class _MentalHealthPageState extends State<MentalHealthPage> {
  late MentalhealthBloc mentalhealthBloc;
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> answers = [];
  String? responseId; // Untuk menyimpan response_id dari CreateAnswersEvent

  @override
  void initState() {
    super.initState();
    mentalhealthBloc = context.read<MentalhealthBloc>();
    _getQuestionnairebyCodeName();
    _createInitialResponse(); // Create response saat init
  }

  _getQuestionnairebyCodeName() async {
    mentalhealthBloc.add(GetQuestionnairebyCodeNameEvent(codeName: "DASS21"));
  }

  // Create response untuk mendapatkan response_id
  _createInitialResponse() async {
    mentalhealthBloc.add(CreateAnswersEvent(
      questionnaireCode: "DASS21",
      // Data ini akan diambil dari local datasource di use case
      userId: "1802010042", 
      namaPegawai: "BAYU TRIO PAMUNGKAS",
      nip: "1802010042",
      jenisPegawai: "MAHASISWA",
      prodi: "Manajemen S1",
      email: "-",
      hp: "085802722390",
    ));
  }

  void _selectOption(String questionId, int questionNo, int score) {
    setState(() {
      // Cari apakah jawaban untuk questionId sudah ada
      int existingIndex = answers.indexWhere((answer) => answer['questionId'] == questionId);
      
      if (existingIndex != -1) {
        // Update jawaban yang sudah ada
        answers[existingIndex] = {
          'questionId': questionId,
          'questionNo': questionNo,
          'score': score,
        };
      } else {
        // Tambah jawaban baru
        answers.add({
          'questionId': questionId,
          'questionNo': questionNo,
          'score': score,
        });
      }
      
      // Sort answers berdasarkan questionNo untuk menjaga urutan
      answers.sort((a, b) => a['questionNo'].compareTo(b['questionNo']));
      
      // Log jawaban saat ini
      _logCurrentAnswers();
    });
  }

  void _logCurrentAnswers() {
    print('=== Current Answers ===');
    print({
      "answers": answers
    });
    print('Total answered: ${answers.length}');
  }

  void _nextQuestion() {
    if (currentQuestionIndex < (mentalhealthBloc.state.dataQuestionnaire?.data.length ?? 0) - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Log final answers dan submit ke API
      _submitFinalAnswers();
    }
  }

  void _submitFinalAnswers() async {
    if (responseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Response ID tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print('=== SUBMITTING FINAL ANSWERS ===');
    final finalAnswers = {
      "answers": answers
    };
    print('Final answers to submit: $finalAnswers');
    print('Response ID: $responseId');
    
    // Kirim jawaban final dengan SaveAnswersEvent
    mentalhealthBloc.add(SaveAnswersEvent(
      answers: answers,
      responseId: responseId!,
    ));
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  bool _isOptionSelected(String questionId, int score) {
    return answers.any((answer) => 
      answer['questionId'] == questionId && answer['score'] == score);
  }

  int? _getSelectedScore(String questionId) {
    try {
      final answer = answers.firstWhere((answer) => answer['questionId'] == questionId);
      return answer['score'];
    } catch (e) {
      return null;
    }
  }

  bool _canProceed() {
    final currentQuestion = mentalhealthBloc.state.dataQuestionnaire?.data[currentQuestionIndex];
    if (currentQuestion == null) return false;
    return answers.any((answer) => answer['questionId'] == currentQuestion.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tes Kesehatan Mental",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 1.h),
            Text(
              "DASS-21 Skrinning",
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        )
      ),
      body: BlocListener<MentalhealthBloc, MentalhealthState>(
        listener: (context, state) {
          // Listen untuk response create answers (untuk mendapatkan response_id)
          if (state.statusCreateAnswers == ResponseValidation.SUCCESS) {
            print('=== CREATE RESPONSE SUCCESS ===');
            print('Response data: ${state.dataCreateAnswers}');
            
            // Ambil response_id dari response
            if (state.dataCreateAnswers?.data != null) {
              setState(() {
                responseId = state.dataCreateAnswers!.data.responseId;
              });
              print('Response ID saved: $responseId');
            }
          } else if (state.statusCreateAnswers == ResponseValidation.FAIL) {
            print('=== FAILED TO CREATE RESPONSE ===');
            print('Error: ${state.messageCreateAnswers}');
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal membuat response: ${state.messageCreateAnswers}'),
                backgroundColor: Colors.red,
              ),
            );
          }

          // Listen untuk response save answers (hasil akhir)
          if (state.statusSaveAnswers == ResponseValidation.SUCCESS) {
            print('=== ANSWERS SAVED SUCCESSFULLY ===');
            print('Response: ${state.messageSaveAnswers}');
            
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Jawaban berhasil disimpan!'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate ke result page setelah berhasil save
            Future.delayed(Duration(seconds: 1), () {
              RouterNavigation.router.push(PAGESNAMES.mentalHealthResult.ScreenPath);
            });
            
          } else if (state.statusSaveAnswers == ResponseValidation.FAIL) {
            print('=== FAILED TO SAVE ANSWERS ===');
            print('Error: ${state.messageSaveAnswers}');
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal menyimpan jawaban: ${state.messageSaveAnswers}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<MentalhealthBloc, MentalhealthState>(
          builder: (context, state) {
            if (state.loadingQuestionnaire == ResponseValidation.LOADING ||
                state.loadingCreateAnswers == ResponseValidation.LOADING) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      state.loadingCreateAnswers == ResponseValidation.LOADING 
                        ? 'Mempersiapkan kuesioner...'
                        : 'Memuat pertanyaan...',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            }

            if (state.statusQuestionnaire == ResponseValidation.FAIL) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50.sp, color: Colors.red),
                    SizedBox(height: 2.h),
                    Text(
                      state.messageQuestionnaire ?? 'Gagal memuat data',
                      style: TextStyle(fontSize: 14.sp, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      onPressed: () => _getQuestionnairebyCodeName(),
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            }

            if (state.statusQuestionnaire == ResponseValidation.SUCCESS && 
                state.dataQuestionnaire != null &&
                responseId != null) { // Pastikan response_id sudah ada
              return Stack(
                children: [
                  _buildQuestionContent(state.dataQuestionnaire!),
                  
                  // Loading overlay saat submit answers
                  if (state.loadingSaveAnswers == ResponseValidation.LOADING)
                    Container(
                      color: Colors.black.withAlpha(127),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Menyimpan jawaban...',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }

            return Center(
              child: Text(
                responseId == null 
                  ? 'Mempersiapkan kuesioner...' 
                  : 'Tidak ada data',
                style: TextStyle(fontSize: 14.sp),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionContent(MentalHealthEntities data) {
    final questions = data.data;
    if (currentQuestionIndex >= questions.length) {
      return Center(
        child: Text(
          'Pertanyaan selesai',
          style: TextStyle(fontSize: 14.sp),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final totalQuestions = questions.length;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 3.h,
          left: 5.w,
          right: 5.w,
        ),
        child: Column(
          children: [
            // Progress indicator
            SizedBox(
              width: sWidthFull(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pertanyaan ${currentQuestionIndex + 1} dari $totalQuestions',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        '${((currentQuestionIndex + 1) / totalQuestions * 100).round()}%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // Question container
            Container(
              width: sWidthFull(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 3.h,
                  left: 5.w,
                  right: 5.w,
                  bottom: 3.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question text
                    Text(
                      "Dalam seminggu terakhir: \"${currentQuestion.text}\"",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText),
                    ),
                    SizedBox(height: 3.h),

                    // Options
                    ...currentQuestion.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isSelected =
                          _isOptionSelected(currentQuestion.id, option.score);

                      return Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: GestureDetector(
                          onTap: () => _selectOption(currentQuestion.id,
                              currentQuestion.number, option.score),
                          child: Container(
                            width: sWidthFull(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? cPrimary
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              color: isSelected
                                  ? cPrimary.withAlpha(25)
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 5.w,
                                right: 5.w,
                                top: 3.h,
                                bottom: 3.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 3.h,
                                    width: 6.w,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? cPrimary
                                          : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                    child: isSelected
                                        ? Icon(Icons.check,
                                            color: Colors.white, size: 16.sp)
                                        : null,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getOptionLabel(option.label),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected
                                                  ? cPrimary
                                                  : Colors.black),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          _getOptionDescription(option.label),
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: isSelected
                                                  ? cPrimary.withAlpha(204)
                                                  : Colors.grey),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          'Score: ${option.score}',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected
                                                  ? cPrimary
                                                  : Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: currentQuestionIndex > 0 ? _previousQuestion : null,
                  child: Container(
                    height: 5.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                      color: currentQuestionIndex > 0
                          ? cBackground
                          : Colors.grey[200],
                      border: Border.all(
                          color: currentQuestionIndex > 0
                              ? Colors.grey.shade300
                              : Colors.grey.shade200,
                          width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 14.sp,
                            color: currentQuestionIndex > 0
                                ? cPrimaryText
                                : Colors.grey,
                          ),
                          Text(
                            "Sebelumnya",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: currentQuestionIndex > 0
                                  ? cPrimaryText
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _canProceed() ? _nextQuestion : null,
                  child: Container(
                    height: 5.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                      color: _canProceed() ? cPrimary : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentQuestionIndex < totalQuestions - 1
                                ? "Selanjutnya"
                                : "Selesai",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: _canProceed() ? Colors.white : Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.sp,
                            color: _canProceed() ? Colors.white : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Debug info (bisa dihapus di production)
            if (answers.isNotEmpty)
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Answered: ${answers.length}/${totalQuestions}',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    if (_getSelectedScore(currentQuestion.id) != null)
                      Text(
                        'Current answer score: ${_getSelectedScore(currentQuestion.id)}',
                        style: TextStyle(fontSize: 10.sp, color: Colors.green),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getOptionLabel(Label label) {
    switch (label) {
      case Label.TIDAK_PERNAH:
        return "Tidak Pernah";
      case Label.KADANG_KADANG:
        return "Kadang-kadang";
      case Label.SERING:
        return "Sering";
      case Label.SANGAT_SERING:
        return "Sangat Sering";
    }
  }

  String _getOptionDescription(Label label) {
    switch (label) {
      case Label.TIDAK_PERNAH:
        return "Tidak berlaku untuk saya sama sekali";
      case Label.KADANG_KADANG:
        return "Berlaku untuk saya sampai taraf tertentu, atau kadang-kadang";
      case Label.SERING:
        return "Berlaku untuk saya sampai taraf yang dapat dikatakan, atau sering";
      case Label.SANGAT_SERING:
        return "Berlaku untuk saya, atau berlaku dikatakan hampir sepanjang waktu";
    }
  }
}
