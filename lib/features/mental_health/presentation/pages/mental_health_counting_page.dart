import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';

class MentalHealthCountingPage extends StatefulWidget {
  const MentalHealthCountingPage({super.key});

  @override
  State<MentalHealthCountingPage> createState() => _MentalHealthCountingPageState();
}

class _MentalHealthCountingPageState extends State<MentalHealthCountingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
              "Menunggu Perhitungan Skor ...", 
              style: TextStyle(
                fontSize: 14.sp, 
                color: cPrimaryText
              ),
            ),
          ],
        ),
      ),
    );
  }
}