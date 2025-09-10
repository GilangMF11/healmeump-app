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
  Map<String, int> selectedAnswers = {}; // questionId -> selectedOptionIndex

  @override
  void initState() {
    super.initState();
    mentalhealthBloc = context.read<MentalhealthBloc>();
    _getQuestionnairebyCodeName();
  }

  _getQuestionnairebyCodeName() async {
    mentalhealthBloc.add(GetQuestionnairebyCodeNameEvent(codeName: "DASS21"));
  }

  void _selectOption(String questionId, int optionIndex) {
    setState(() {
      selectedAnswers[questionId] = optionIndex;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < (mentalhealthBloc.state.dataQuestionnaire?.data.length ?? 0) - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Navigate to result page
      RouterNavigation.router.push(PAGESNAMES.mentalHealthResult.ScreenPath);
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  bool _isOptionSelected(String questionId, int optionIndex) {
    return selectedAnswers[questionId] == optionIndex;
  }

  bool _canProceed() {
    final currentQuestion = mentalhealthBloc.state.dataQuestionnaire?.data[currentQuestionIndex];
    if (currentQuestion == null) return false;
    return selectedAnswers.containsKey(currentQuestion.id);
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
          )),
      body: BlocBuilder<MentalhealthBloc, MentalhealthState>(
        builder: (context, state) {
          if (state.loadingQuestionnaire == ResponseValidation.LOADING) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
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
              state.dataQuestionnaire != null) {
            return _buildQuestionContent(state.dataQuestionnaire!);
          }

          return Center(
            child: Text(
              'Tidak ada data',
              style: TextStyle(fontSize: 14.sp),
            ),
          );
        },
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
                    color: Colors.black.withValues(alpha: 0.1),
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
                      final isSelected = _isOptionSelected(currentQuestion.id, index);
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: GestureDetector(
                          onTap: () => _selectOption(currentQuestion.id, index),
                          child: Container(
                            width: sWidthFull(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? cPrimary : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              color: isSelected ? cPrimary.withValues(alpha: 0.01) : Colors.white,
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
                                    width: 3.w,
                                    decoration: BoxDecoration(
                                      color: isSelected ? cPrimary : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _getOptionLabel(option.label),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? cPrimary : Colors.black),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          _getOptionDescription(option.label),
                                          style: TextStyle(
                                              fontSize: 12.sp, 
                                              color: isSelected ? cPrimary.withValues(alpha: 0.8) : Colors.grey),
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
                      color: currentQuestionIndex > 0 ? cBackground : Colors.grey[200],
                      border: Border.all(
                        color: currentQuestionIndex > 0 ? Colors.grey.shade300 : Colors.grey.shade200, 
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        spacing: 1.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios, 
                            size: 14.sp, 
                            color: currentQuestionIndex > 0 ? cPrimaryText : Colors.grey,
                          ),
                          Text(
                            "Sebelumnya", 
                            style: TextStyle(
                              fontSize: 14.sp, 
                              fontWeight: FontWeight.bold, 
                              color: currentQuestionIndex > 0 ? cPrimaryText : Colors.grey,
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
                        spacing: 1.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentQuestionIndex < totalQuestions - 1 ? "Selanjutnya" : "Selesai", 
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
