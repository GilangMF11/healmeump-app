import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hasil Tes Kesehatan Mental",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 1.h),
              Text(
                "1 September 2025",
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ],
          )),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5.h,
                left: 5.w,
                right: 5.w
              ),
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: sWidthFull(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}