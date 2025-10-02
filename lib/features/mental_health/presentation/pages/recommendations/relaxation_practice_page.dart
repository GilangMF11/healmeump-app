import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RelaxationPracticePage extends StatelessWidget {
  const RelaxationPracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Praktik Relaksasi",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: cPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.self_improvement,
                    color: cPrimary,
                    size: 32.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Praktik Relaksasi",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Lakukan teknik pernapasan dalam, meditasi, atau yoga untuk mengurangi kecemasan dan meningkatkan kesejahteraan mental Anda.",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: cPrimaryText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 4.h),
            
            // Video Section
            Text(
              "Video Panduan",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // Video 1: Nafas Dalam
            _buildVideoCard(
              context,
              "Teknik Pernapasan Dalam",
              "Pelajari cara melakukan pernapasan dalam yang efektif untuk mengurangi stres dan kecemasan.",
              "https://youtu.be/MkDWWapNqr8?si=n8WkizHNGeL-vzUk", // Ganti dengan URL YouTube yang sebenarnya
              Icons.air,
              Colors.blue,
            ),
            
            SizedBox(height: 2.h),
            
            // Video 2: Meditasi
            _buildVideoCard(
              context,
              "Meditasi Mindfulness",
              "Panduan meditasi mindfulness untuk menenangkan pikiran dan meningkatkan fokus.",
              "https://youtu.be/yWoOLDz3gVY?si=uV9HiCAaLHLyyB-a", // Ganti dengan URL YouTube yang sebenarnya
              Icons.psychology,
              Colors.purple,
            ),
            
            SizedBox(height: 2.h),
            
            // Video 3: Yoga
            _buildVideoCard(
              context,
              "Yoga untuk Relaksasi",
              "Gerakan yoga sederhana yang dapat dilakukan di rumah untuk relaksasi dan fleksibilitas.",
              "https://youtu.be/6H6jt4nzDwk?si=GBEw8VriP_3zegNf", // Ganti dengan URL YouTube yang sebenarnya
              Icons.self_improvement,
              Colors.green,
            ),
            
            SizedBox(height: 4.h),
            
            // Tips Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.orange,
                        size: 24.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Tips Praktis",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildTipItem("Lakukan di tempat yang tenang dan nyaman"),
                  _buildTipItem("Mulai dengan durasi 5-10 menit, kemudian tingkatkan"),
                  _buildTipItem("Fokus pada pernapasan dan biarkan pikiran mengalir"),
                  _buildTipItem("Lakukan secara konsisten setiap hari"),
                  _buildTipItem("Jangan memaksakan diri jika merasa tidak nyaman"),
                ],
              ),
            ),
            
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    String title,
    String description,
    String url,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchYouTubeVideo(url),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.red,
                  size: 32.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.w,
            height: 1.w,
            margin: EdgeInsets.only(top: 1.h, right: 3.w),
            decoration: BoxDecoration(
              color: Colors.orange[800],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.orange[800],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchYouTubeVideo(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching YouTube video: $e');
    }
  }
}
