import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class DepressionPage extends StatefulWidget {
  final String questionnaireCode;
  final String userId;
  final String namaPegawai;
  final String nip;
  final String jenisPegawai;
  final String prodi;
  final String email;
  final String hp;

  const DepressionPage({
    super.key,
    required this.questionnaireCode,
    required this.userId,
    required this.namaPegawai,
    required this.nip,
    required this.jenisPegawai,
    required this.prodi,
    required this.email,
    required this.hp,
  });

  @override
  State<DepressionPage> createState() => _DepressionPageState();
}

class _DepressionPageState extends State<DepressionPage> {
  late MentalhealthBloc mentalhealthBloc;
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> answers = [];
  String? responseId; // Untuk menyimpan response_id dari CreateAnswersEvent
  bool _hasCreatedResponse = false; // Flag untuk mencegah create response berulang
  bool _hasNavigatedToCounting = false; // Flag untuk mencegah navigasi berulang ke counting page

  @override
  void initState() {
    super.initState();
    mentalhealthBloc = context.read<MentalhealthBloc>();
    
    // Reset state jika ada data dari tes sebelumnya
    _resetStateIfNeeded();
    
    _getQuestionnairebyCodeName();
    
    // Create response hanya jika belum pernah dibuat
    if (!_hasCreatedResponse) {
      _createInitialResponse(); // Create response saat init
    }
  }

  // Reset state jika ada data dari tes sebelumnya
  void _resetStateIfNeeded() {
    final currentState = mentalhealthBloc.state;
    
    // Jika ada data submit answers dari tes sebelumnya, reset state
    if (currentState.statusSubmitAnswers == ResponseValidation.SUCCESS ||
        currentState.statusSaveAnswers == ResponseValidation.SUCCESS) {
      print('=== RESETTING STATE FROM PREVIOUS TEST ===');
      
      // Reset flags
      _hasCreatedResponse = false;
      _hasNavigatedToCounting = false;
      currentQuestionIndex = 0;
      answers.clear();
      responseId = null;
      
      // Reset state di bloc
      mentalhealthBloc.add(ResetMentalHealthStateEvent());
    }
  }

  _getQuestionnairebyCodeName() async {
    mentalhealthBloc.add(GetQuestionnairebyCodeNameEvent(codeName: "BDI2"));
  }

  // Create response untuk mendapatkan response_id
  _createInitialResponse() async {
    if (!_hasCreatedResponse) {
      _hasCreatedResponse = true; // Set flag agar tidak create lagi
      mentalhealthBloc.add(CreateAnswersEvent(
        questionnaireCode: widget.questionnaireCode,
        // Data ini akan diambil dari local datasource di use case
        userId: widget.userId, 
        namaPegawai: widget.namaPegawai,
        nip: widget.nip,
        jenisPegawai: widget.jenisPegawai,
        prodi: widget.prodi,
        email: widget.email,
        hp: widget.hp,
      ));
    }
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

    // Pastikan ada jawaban yang akan disimpan
    if (answers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Tidak ada jawaban yang akan disimpan'),
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
    print('Answers count: ${answers.length}');
    
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
              "Tes Depresi",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 1.h),
            Text(
              "Beck Depression Inventory (BDI)",
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        )
      ),
      body: BlocListener<MentalhealthBloc, MentalhealthState>(
        listener: (context, state) {
          // Listen untuk response create answers (untuk mendapatkan response_id)
          if (state.statusCreateAnswers == ResponseValidation.LOADED) {
            // Tunggu sampai status berubah ke SUCCESS
          } else if (state.statusCreateAnswers == ResponseValidation.SUCCESS) {
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

          // Listen untuk response save answers (setelah save, navigate ke counting page)
          if (state.statusSaveAnswers == ResponseValidation.LOADED) {
            // Tunggu sampai status berubah ke SUCCESS
          } else if (state.statusSaveAnswers == ResponseValidation.SUCCESS && 
              !_hasNavigatedToCounting && 
              answers.isNotEmpty) { // Pastikan ada jawaban yang disimpan
            print('=== ANSWERS SAVED SUCCESSFULLY ===');
            print('Response: ${state.messageSaveAnswers}');
            print('Answers count: ${answers.length}');
            
            // Set flag untuk mencegah navigasi berulang
            _hasNavigatedToCounting = true;
            
            // Navigate ke counting page untuk submit answers dengan delay
            Future.delayed(Duration(milliseconds: 500), () {
              if (mounted && _hasNavigatedToCounting) {
                print('=== NAVIGATING TO COUNTING PAGE ===');
                RouterNavigation.router.push(PAGESNAMES.depressionCounting.ScreenPath);
              }
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
                state.loadingCreateAnswers == ResponseValidation.LOADING ||
                state.loadingSaveAnswers == ResponseValidation.LOADING ||
                state.loadingSubmitAnswers == ResponseValidation.LOADING) {
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
                        : state.loadingSaveAnswers == ResponseValidation.LOADING
                          ? 'Menyimpan jawaban...'
                          : state.loadingSubmitAnswers == ResponseValidation.LOADING
                            ? 'Mengirim jawaban...'
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
                      'Gagal memuat kuesioner',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      state.messageQuestionnaire ?? 'Terjadi kesalahan',
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
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Menyimpan jawaban...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Memuat kuesioner...',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionContent(dynamic questionnaire) {
    final questions = questionnaire.data;
    final currentQuestion = questions[currentQuestionIndex];
    final totalQuestions = questions.length;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            Container(
              width: sWidthFull(context),
              height: 0.5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (currentQuestionIndex + 1) / totalQuestions,
                child: Container(
                  decoration: BoxDecoration(
                    color: cPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // Question Number
            Text(
              'Pertanyaan ${currentQuestionIndex + 1} dari $totalQuestions',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // Question Text
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
              child: Text(
                currentQuestion.text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: cPrimaryText,
                  height: 1.5,
                ),
              ),
            ),
            
            SizedBox(height: 3.h),
            
            // Options
            ...currentQuestion.meta.options.map<Widget>((option) {
              // Handle both Map<String, dynamic> and Option object
              final score = option is Map<String, dynamic> ? option['score'] as int : option.score;
              final label = option is Map<String, dynamic> ? option['label'] as String : option.label;
              final isSelected = _isOptionSelected(currentQuestion.id, score);
              return GestureDetector(
                onTap: () {
                  _selectOption(currentQuestion.id, currentQuestion.number, score);
                },
                child: Container(
                  width: sWidthFull(context),
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: isSelected ? cPrimary.withValues(alpha: 0.1) : Colors.white,
                    border: Border.all(
                      color: isSelected ? cPrimary : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? cPrimary : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? cPrimary : Colors.grey[400]!,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 3.w,
                            )
                          : null,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isSelected ? cPrimary : cPrimaryText,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            
            SizedBox(height: 4.h),
            
            // Navigation Buttons
            Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: GestureDetector(
                      onTap: _previousQuestion,
                      child: Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: cBackground,
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Sebelumnya",
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
                
                if (currentQuestionIndex > 0) SizedBox(width: 3.w),
                
                Expanded(
                  child: GestureDetector(
                    onTap: _canProceed() ? _nextQuestion : null,
                    child: Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: _canProceed() ? cPrimary : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          currentQuestionIndex == totalQuestions - 1 ? "Selesai" : "Selanjutnya",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: _canProceed() ? Colors.white : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}