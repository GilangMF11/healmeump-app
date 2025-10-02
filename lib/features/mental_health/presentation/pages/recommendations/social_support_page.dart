import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';

class SocialSupportPage extends StatelessWidget {
  const SocialSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Dukungan Sosial",
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
                    Icons.people,
                    color: cPrimary,
                    size: 32.sp,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Dukungan Sosial",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Jaga hubungan dengan keluarga dan teman. Berbicara tentang perasaan dapat membantu. Ikuti panduan A-I-P-E-C untuk mendapatkan dukungan yang efektif.",
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
            
            // AIPE-C Framework
            Text(
              "Panduan A-I-P-E-C",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
            ),
            
            SizedBox(height: 2.h),
            
            // A - ATTEND
            _buildFrameworkCard(
              "A - ATTEND (Hadir Sepenuhnya)",
              Icons.person,
              Colors.blue,
              [
                "Sadari kebutuhan Anda: Sebelum mencari dukungan, luangkan waktu sejenak untuk mengenali apa yang Anda rasakan dan butuhkan. Apakah Anda hanya perlu didengar, butuh saran, atau butuh bantuan praktis?",
                "Cari lingkungan yang nyaman",
                "Komunikasikan kebutuhan Anda"
              ],
            ),
            
            SizedBox(height: 2.h),
            
            // I - INQUIRE
            _buildFrameworkCard(
              "I - INQUIRE (Bertanya dengan Penuh Rasa Ingin Tahu)",
              Icons.help_outline,
              Colors.green,
              [
                "Siapkan pertanyaan untuk diri sendiri: Sebelum berbicara dengan orang lain, tanyakan pada diri sendiri:",
                "• Apa yang sebenarnya saya rasakan saat ini?",
                "• Apa pemicu perasaan ini?",
                "• Apa yang paling saya butuhkan sekarang?"
              ],
            ),
            
            SizedBox(height: 2.h),
            
            // P - PROVIDE
            _buildFrameworkCard(
              "P - PROVIDE (Memberikan)",
              Icons.favorite,
              Colors.red,
              [
                "Terima validasi emosional: Izinkan diri Anda untuk menerima pengakuan atas perasaan Anda.",
                "Jelas dalam meminta bantuan: Jika Anda membutuhkan bantuan spesifik, sampaikan dengan jelas.",
                "Jangan ragu menerima bantuan praktis: Jika seseorang menawarkan bantuan konkret (seperti berbagi catatan atau menemani ke konseling), terima dengan terbuka."
              ],
            ),
            
            SizedBox(height: 2.h),
            
            // E - EMPOWER
            _buildFrameworkCard(
              "E - EMPOWER (Memberdayakan)",
              Icons.psychology,
              Colors.purple,
              [
                "Identifikasi kekuatan Anda",
                "Jika seseorang memberikan saran, jangan ragu untuk mengajukan alternatif lain yang mungkin lebih sesuai untuk Anda."
              ],
            ),
            
            SizedBox(height: 2.h),
            
            // C - CHECK
            _buildFrameworkCard(
              "C - CHECK (Memeriksa Kembali)",
              Icons.check_circle,
              Colors.orange,
              [
                "Berikan umpan balik: Katakan dengan jujur apakah dukungan yang diberikan membantu atau tidak.",
                "Contoh: \"Terima kasih sudah mendengarkan. Sekarang saya merasa lebih lega,\" atau \"Saya menghargai bantuannya, tapi saya mungkin butuh pendekatan yang sedikit berbeda.\"",
                "Lakukan follow-up: Jika seseorang telah membantu Anda, beri tahu mereka tentang perkembangan situasi Anda. Ini menunjukkan apresiasi dan memperkuat hubungan.",
                "Evaluasi diri: Secara berkala, tanyakan pada diri sendiri: \"Apakah dukungan yang saya terima sudah cukup? Apakah ada kebutuhan lain yang belum terpenuhi?\""
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
                  _buildTipItem("Pilih orang yang Anda percaya dan nyaman untuk diajak bicara"),
                  _buildTipItem("Jangan takut untuk meminta bantuan profesional jika diperlukan"),
                  _buildTipItem("Bangun jaringan dukungan yang beragam (keluarga, teman, komunitas)"),
                  _buildTipItem("Berikan dukungan kepada orang lain juga - ini dapat memperkuat hubungan"),
                  _buildTipItem("Hargai setiap bentuk dukungan yang Anda terima"),
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
                "Sumber: Jones et al. (2023)",
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

  Widget _buildFrameworkCard(String title, IconData icon, Color color, List<String> content) {
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
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ...content.map((item) => _buildContentItem(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          color: cPrimaryText,
          height: 1.5,
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
}
