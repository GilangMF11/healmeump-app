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
                    height: 30.h,
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 2.h,
                        left: 5.w,
                        right: 5.w
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ringkasan Hasil", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: cPrimaryText),),
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Depresi", style: TextStyle(fontSize: 14.sp, color: cPrimaryText),),
                              Container(
                                height: 3.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0FDF4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Normal", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFF2A8235)),),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h),
                          // Indicator Bar
                          Container(
                            height: 1.h,
                            width: sWidthFull(context),
                            decoration: BoxDecoration(
                              color: Color(0xFFDDECEC),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 1.h,
                                width: 5.w,
                                decoration: BoxDecoration(
                                  color: cPrimary,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kecemasan", style: TextStyle(fontSize: 14.sp, color: cPrimaryText),),
                              Container(
                                height: 3.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFDF2F2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Mengalami", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFFC61627)),),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h),
                          // Indicator Bar
                          Container(
                            height: 1.h,
                            width: sWidthFull(context),
                            decoration: BoxDecoration(
                              color: Color(0xFFDDECEC),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 1.h,
                                width: 55.w,
                                decoration: BoxDecoration(
                                  color: cPrimary,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Stres", style: TextStyle(fontSize: 14.sp, color: cPrimaryText),),
                              Container(
                                height: 3.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0FDF4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Normal", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Color(0xFF2A8235)),),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h),
                          // Indicator Bar
                          Container(
                            height: 1.h,
                            width: sWidthFull(context),
                            decoration: BoxDecoration(
                              color: Color(0xFFDDECEC),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 1.h,
                                width: 5.w,
                                decoration: BoxDecoration(
                                  color: cPrimary,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 5.h,
                    width: sWidthFull(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cBackground,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.loop,
                            color: cPrimaryText,
                            size: 20.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text("Ulangi Tes", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: cPrimaryText),),
                        ],
                      ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}