import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tampilan Tidak Ditemukan', style: TextStyle(color: Colors.red, fontSize: 16.sp),),
      )
    );
  }
}
