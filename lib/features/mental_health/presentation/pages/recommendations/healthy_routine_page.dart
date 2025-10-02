import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';

class HealthyRoutinePage extends StatelessWidget {
  const HealthyRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Rutinitas Sehat",
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
                    Icons.schedule,
                    color: cPrimary,
                    size: 32.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Rutinitas Sehat",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Jaga pola tidur yang teratur, makan makanan bergizi, dan hindari konsumsi berlebihan untuk kesehatan mental yang optimal.",
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
            
            // Pola Nutrisi Section
            _buildSectionCard(
              "Pola Nutrisi",
              Icons.restaurant,
              Colors.green,
              [
                _buildNutritionItem(
                  "Isi Piringku",
                  "½ piring diisi dengan sayur dan buah, ¼ piring diisi dengan lauk pauk, dan ¼ isi dengan makanan pokok seperti nasi, jagung, singkong, gandum",
                ),
                _buildNutritionItem(
                  "Batasi Makanan Olahan",
                  "Batasi/kurangi konsumsi makanan olahan",
                ),
                _buildNutritionItem(
                  "Hidrasi yang Cukup",
                  "Minum 8 gelas air putih setiap hari",
                ),
              ],
              "Sumber: Kementerian Kesehatan RI. (2021)",
            ),
            
            SizedBox(height: 3.h),
            
            // Pola Tidur Section
            _buildSectionCard(
              "Jaga Pola Tidur",
              Icons.bedtime,
              Colors.blue,
              [
                _buildSleepItem(
                  "Durasi",
                  "7-9 jam per malam untuk dewasa",
                ),
                _buildSleepItem(
                  "Kualitas",
                  "Pertahankan waktu tidur/bangun yang konsisten, ciptakan lingkungan yang gelap dan sejuk, dan hindari kafein/alkohol sebelum tidur",
                ),
                _buildSleepItem(
                  "Teknologi",
                  "Hindari paparan cahaya biru dari layar setidaknya 1 jam sebelum tidur",
                ),
              ],
              "Sumber: Chaput, J. P., et al. (2020)",
            ),
            
            SizedBox(height: 3.h),
            
            // Hindari Perilaku Berisiko Section
            _buildSectionCard(
              "Hindari Perilaku Berisiko",
              Icons.warning,
              Colors.red,
              [
                _buildRiskItem(
                  "Tembakau dan Alkohol",
                  "Hindari semua bentuk tembakau dan alkohol. Tidak ada tingkat konsumsi alkohol yang benar-benar aman untuk kesehatan.",
                ),
              ],
              "Sumber: Biddinger, K. J., et al. (2022)",
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
                  _buildTipItem("Buat jadwal makan yang teratur setiap hari"),
                  _buildTipItem("Siapkan makanan sehat di malam hari untuk hari berikutnya"),
                  _buildTipItem("Gunakan aplikasi untuk melacak pola tidur dan nutrisi"),
                  _buildTipItem("Buat rutinitas sebelum tidur yang menenangkan"),
                  _buildTipItem("Hindari makan besar 2-3 jam sebelum tidur"),
                  _buildTipItem("Kurangi konsumsi kafein di sore dan malam hari"),
                ],
              ),
            ),
            
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Color color, List<Widget> children, String source) {
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
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                source,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
              color: cPrimaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepItem(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
              color: cPrimaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskItem(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
              color: cPrimaryText,
              height: 1.4,
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
