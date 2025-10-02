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

class MentalHealthCountingPage extends StatefulWidget {
  const MentalHealthCountingPage({super.key});

  @override
  State<MentalHealthCountingPage> createState() => _MentalHealthCountingPageState();
}

class _MentalHealthCountingPageState extends State<MentalHealthCountingPage> {
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
    
    print('=== COUNTING PAGE INIT ===');
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
        
        print('=== EXECUTING SUBMIT ANSWERS FROM COUNTING PAGE ===');
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
                  RouterNavigation.router.push(PAGESNAMES.mentalHealthResult.ScreenPath);
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
                  RouterNavigation.router.push(PAGESNAMES.mentalHealthResult.ScreenPath);
                }
              });
            }
            
          } else if (state.loadingSubmitAnswers == ResponseValidation.LOADED && 
                     state.statusSubmitAnswers == ResponseValidation.FAIL && 
                     !_hasNavigated) {
            print('=== FAILED TO SUBMIT ANSWERS IN COUNTING PAGE ===');
            print('Error: ${state.messageSubmitAnswers}');
            
            // Set flag untuk mencegah navigation berulang
            _hasNavigated = true;
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal mengirim jawaban: ${state.messageSubmitAnswers}'),
                  backgroundColor: Colors.red,
                ),
              );
              
              // Navigate back to mental health page on error
              Future.delayed(Duration(seconds: 2), () {
                if (mounted && _hasNavigated) {
                  RouterNavigation.router.pop();
                }
              });
            }
          }
        },
        child: BlocBuilder<MentalhealthBloc, MentalhealthState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icon-checkmark.png'),
                  SizedBox(height: 2.h),
                  Text(
                    "Selesai", 
                    style: TextStyle(
                      fontSize: 20.sp, 
                      fontWeight: FontWeight.bold, 
                      color: cPrimaryText
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    state.loadingSubmitAnswers == ResponseValidation.LOADING
                      ? "Mengirim jawaban dan menghitung skor..."
                      : "Menunggu Perhitungan Skor ...", 
                    style: TextStyle(
                      fontSize: 14.sp, 
                      color: cPrimaryText
                    ),
                  ),
                  SizedBox(height: 2.h),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}