import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 3.h,
            left: 5.w,
            right: 5.w,
          ),
          child: Column(
            children: [
              Container(
                height: 70.h,
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
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 5.h,
                          width: sHeightFull(context),
                          child: Text(
                            "Dalam seminggu terakhir: “Saya merasa sulit untuk bersantai”",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: cPrimaryText),
                          )),
                      SizedBox(height: 2.h),
                      Container(
                          height: 12.h,
                          width: sWidthFull(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 3.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 3.w,
                                  decoration: BoxDecoration(
                                    color: cPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Column(
                                  spacing: 0.5.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tidak Pernah",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Tidak berlaku untuk saya sama sekali",
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(height: 2.h),
                      Container(
                          height: 12.h,
                          width: sWidthFull(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 3.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 3.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Column(
                                  spacing: 0.5.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kadang-kadang",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      height: 5.h,
                                      child: Text(
                                        "Berlaku untuk saya sampai taraf tertentu, atau kadang-kadang",
                                        style: TextStyle(
                                            fontSize: 12.sp, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(height: 2.h),
                      Container(
                          height: 12.h,
                          width: sWidthFull(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 3.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 3.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Column(
                                  spacing: 0.5.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sering",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      height: 5.h,
                                      child: Text(
                                        "Berlaku untuk saya sampai taraf yang dapat dikatakan, atau sering",
                                        style: TextStyle(
                                            fontSize: 12.sp, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(height: 2.h),
                      Container(
                          height: 12.h,
                          width: sWidthFull(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                              top: 3.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 3.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Column(
                                  spacing: 0.5.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hampir Selalu",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                      height: 5.h,
                                      child: Text(
                                        "Berlaku untuk saya, atau belaku dikatakan hampir sepanjang waktu",
                                        style: TextStyle(
                                            fontSize: 12.sp, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 5.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                      color: cBackground,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        spacing: 1.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios, size: 14.sp, color: cPrimaryText,),
                          Text("Sebelumhya", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: cPrimaryText),),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RouterNavigation.router.push(PAGESNAMES.mentalHealthResult.ScreenPath);
                    },
                    child: Container(
                      height: 5.h,
                      width: 43.w,
                      decoration: BoxDecoration(
                        color: cPrimary,
                        //border: Border.all(color: Colors.grey.shade300, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          spacing: 1.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Selanjutnya", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                            Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
