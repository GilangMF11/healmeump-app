import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';

class PhysicalActivityPage extends StatelessWidget {
  const PhysicalActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Aktivitas Fisik",
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
                    Icons.directions_run,
                    color: cPrimary,
                    size: 32.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Aktivitas Fisik",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Olahraga teratur dapat membantu mengurangi stres dan meningkatkan mood. Ikuti panduan aktivitas fisik yang direkomendasikan WHO.",
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
            
            // Aerobik Section
            _buildSectionCard(
              "Aktivitas Aerobik",
              Icons.fitness_center,
              Colors.blue,
              [
                _buildActivityItem(
                  "Intensitas Sedang",
                  "Lakukan setidaknya 150-300 menit aerobik intensitas sedang seperti:",
                  [
                    "Jalan cepat",
                    "Bersepeda santai",
                    "Berenang",
                    "Berdansa",
                    "Tenis ganda"
                  ],
                ),
                _buildActivityItem(
                  "Intensitas Kuat",
                  "Lakukan setidaknya 75-150 menit aerobik intensitas kuat seperti:",
                  [
                    "Bersepeda cepat",
                    "Lompat tali",
                    "Lari",
                    "Mendaki",
                    "Tenis tunggal"
                  ],
                ),
                _buildActivityItem(
                  "Kombinasi",
                  "Lakukan kombinasi yang setara dari aktivitas intensitas sedang dan kuat sepanjang minggu",
                  [],
                ),
              ],
            ),
            
            SizedBox(height: 3.h),
            
            // Muscle Strengthening Section
            _buildSectionCard(
              "Aktivitas Penguatan Otot",
              Icons.fitness_center,
              Colors.green,
              [
                _buildActivityItem(
                  "Rekomendasi",
                  "Lakukan aktivitas penguatan otot dengan intensitas sedang 2 hari atau lebih dalam seminggu seperti:",
                  [
                    "Angkat beban",
                    "Push-up",
                    "Pull-up",
                    "Squat",
                    "Plank"
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 3.h),
            
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
                        "Tips Penting",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildTipItem("Mulai dengan intensitas ringan dan tingkatkan secara bertahap"),
                  _buildTipItem("Lakukan pemanasan sebelum berolahraga"),
                  _buildTipItem("Minum air yang cukup sebelum, selama, dan setelah berolahraga"),
                  _buildTipItem("Konsultasikan dengan dokter jika memiliki kondisi kesehatan tertentu"),
                  _buildTipItem("Dengarkan tubuh Anda dan beristirahat jika diperlukan"),
                ],
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // Source
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Sumber: WHO, 2020",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Color color, List<Widget> children) {
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
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: cPrimaryText,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String description, List<String> activities) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
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
              fontSize: 14.sp,
              color: cPrimaryText,
              height: 1.4,
            ),
          ),
          if (activities.isNotEmpty) ...[
            SizedBox(height: 2.h),
            ...activities.map((activity) => _buildActivityListItem(activity)).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildActivityListItem(String activity) {
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
              color: cPrimary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                fontSize: 13.sp,
                color: cPrimaryText,
                height: 1.4,
              ),
            ),
          ),
        ],
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
}
