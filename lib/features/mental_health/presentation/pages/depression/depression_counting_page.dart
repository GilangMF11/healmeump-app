import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class DepressionCountingPage extends StatefulWidget {
  const DepressionCountingPage({super.key});

  @override
  State<DepressionCountingPage> createState() => _DepressionCountingPageState();
}

class _DepressionCountingPageState extends State<DepressionCountingPage> {
  late MentalhealthBloc mentalhealthBloc;
  String? responseId;
  bool _hasSubmitted = false; // Flag untuk mencegah submit berulang
  bool _hasNavigated = false; // Flag untuk mencegah navigation berulang

  @override
  void initState() {
    super.initState();
    mentalhealthBloc = context.read<MentalhealthBloc>();
    
    // Reset flags untuk memastikan tes baru bisa berjalan
    _hasSubmitted = false;
    _hasNavigated = false;
    
    // Ambil responseId dari state
    final currentState = mentalhealthBloc.state;
    responseId = currentState.dataCreateAnswers?.data.responseId;
    
    print('=== DEPRESSION COUNTING PAGE INIT ===');
    print('Response ID: $responseId');
    print('Loading status: ${currentState.loadingSubmitAnswers}');
    print('Submit status: ${currentState.statusSubmitAnswers}');
    
    // Eksekusi submit answers ketika page dimuat
    if (responseId != null) {
      // Reset submit state jika ada data dari tes sebelumnya
      if (currentState.statusSubmitAnswers == ResponseValidation.SUCCESS ||
          currentState.statusSubmitAnswers == ResponseValidation.FAIL) {
        print('=== RESETTING SUBMIT STATE FROM PREVIOUS TEST ===');
        mentalhealthBloc.add(ResetSubmitStateEvent());
      }
      
      // Submit answers jika belum pernah submit atau gagal
      if (currentState.loadingSubmitAnswers != ResponseValidation.LOADING &&
          currentState.statusSubmitAnswers != ResponseValidation.SUCCESS) {
        
        print('=== EXECUTING SUBMIT ANSWERS FROM DEPRESSION COUNTING PAGE ===');
        _hasSubmitted = true; // Set flag agar tidak submit lagi
        
        // Delay sedikit untuk memastikan widget sudah siap
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _hasSubmitted && !_hasNavigated) {
            mentalhealthBloc.add(SubmitAnswersEvent(responseId: responseId!));
          }
        });
      } else {
        print('=== SUBMIT ALREADY IN PROGRESS OR COMPLETED ===');
        if (currentState.statusSubmitAnswers == ResponseValidation.SUCCESS) {
          // Jika sudah berhasil, langsung navigate
          _hasNavigated = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Future.delayed(Duration(seconds: 1), () {
                if (mounted && _hasNavigated) {
                  RouterNavigation.router.push(PAGESNAMES.depressionResult.ScreenPath);
                }
              });
            }
          });
        }
      }
    } else {
      print('=== ERROR: Response ID not found ===');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Response ID tidak ditemukan'),
            backgroundColor: Colors.red,
          ),
        );
        
        // Navigate back jika tidak ada response ID
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            RouterNavigation.router.pop();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimary,
      body: BlocListener<MentalhealthBloc, MentalhealthState>(
        listener: (context, state) {
          // Listen untuk response submit answers (hasil akhir)
          if (state.loadingSubmitAnswers == ResponseValidation.LOADED && 
              state.statusSubmitAnswers == ResponseValidation.SUCCESS && 
              !_hasNavigated) {
            print('=== SUBMIT ANSWERS SUCCESS IN COUNTING PAGE ===');
            print('Response: ${state.messageSubmitAnswers}');
            print('Data: ${state.dataSubmitAnswers}');
            
            // Set flag untuk mencegah navigation berulang
            _hasNavigated = true;
            
            // Navigate ke result page setelah berhasil submit (hanya sekali)
            if (mounted) {
              Future.delayed(Duration(seconds: 2), () {
                if (mounted && _hasNavigated) {
                  RouterNavigation.router.push(PAGESNAMES.depressionResult.ScreenPath);
                }
              });
            }
          } else if (state.statusSubmitAnswers == ResponseValidation.FAIL) {
            print('=== FAILED TO SUBMIT ANSWERS IN COUNTING PAGE ===');
            print('Error: ${state.messageSubmitAnswers}');
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal mengirim jawaban: ${state.messageSubmitAnswers}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: BlocBuilder<MentalhealthBloc, MentalhealthState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Loading Animation
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  // Title
                  Text(
                    "Memproses Hasil",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  // Description
                  Text(
                    "Sedang menganalisis jawaban Anda...",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  // Progress Steps
                  _buildProgressStep(
                    "Menyimpan jawaban",
                    state.statusSaveAnswers == ResponseValidation.SUCCESS,
                    state.loadingSaveAnswers == ResponseValidation.LOADING,
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  _buildProgressStep(
                    "Menganalisis hasil",
                    state.statusSubmitAnswers == ResponseValidation.SUCCESS,
                    state.loadingSubmitAnswers == ResponseValidation.LOADING,
                  ),
                  
                  SizedBox(height: 2.h),
                  
                  _buildProgressStep(
                    "Menyiapkan laporan",
                    state.statusSubmitAnswers == ResponseValidation.SUCCESS,
                    false,
                  ),
                  
                  SizedBox(height: 6.h),
                  
                  // Loading Text
                  if (state.loadingSubmitAnswers == ResponseValidation.LOADING)
                    Text(
                      "Mohon tunggu sebentar...",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressStep(String title, bool isCompleted, bool isLoading) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: isCompleted 
              ? Colors.white 
              : isLoading 
                ? Colors.white.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: isCompleted
            ? Icon(
                Icons.check,
                color: cPrimary,
                size: 3.w,
              )
            : isLoading
              ? SizedBox(
                  width: 3.w,
                  height: 3.w,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : null,
        ),
        
        SizedBox(width: 3.w),
        
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: isCompleted 
                ? Colors.white 
                : Colors.white.withValues(alpha: 0.7),
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
