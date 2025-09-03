import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        backgroundColor: cPrimary,
        title: Text(
          "Kontak & Bantuan",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 3.h),
              
              // Dukungan Aplikasi Section
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Dukungan Aplikasi',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      
                      // Subtitle
                      Text(
                        'Bantuan untuk penggunaan aplikasi',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // Email Contact
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: cPrimaryText,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                GestureDetector(
                                  onTap: () => _launchEmail('hendra4edu@gmail.com'),
                                  child: Text(
                                    'hendra4edu@gmail.com',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.blue[600],
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  'Seputar Aplikasi dan pertanyaan umum',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // FAQ Section
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Pertanyaan Sering Diajukan',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // FAQ Items
                      Column(
                        children: [
                          _buildFAQItem(
                            question: 'Bagaimana cara membaca hasil tes?',
                            answer: 'Pelajari interpretasi skor dan rekomendasi',
                          ),
                          
                          SizedBox(height: 2.h),
                          
                          _buildFAQItem(
                            question: 'Apakah data saya aman?',
                            answer: 'Informasi tentang keamanan dan privasi data',
                          ),
                          
                          SizedBox(height: 2.h),
                          
                          _buildFAQItem(
                            question: 'Seberapa sering sebaiknya melakukan tes?',
                            answer: 'Rekomendasi frekuensi penggunaan aplikasi',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 3.h),
              
              // Additional Support Options
              Container(
                width: sWidthFull(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Layanan Lainnya',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // Support Options
                      _buildSupportOption(
                        icon: Icons.help_outline,
                        title: 'Panduan Penggunaan',
                        subtitle: 'Tutorial lengkap penggunaan aplikasi',
                        onTap: () {
                          // Navigate to user guide
                        },
                      ),
                      
                      SizedBox(height: 1.5.h),
                      
                      _buildSupportOption(
                        icon: Icons.bug_report,
                        title: 'Laporkan Bug',
                        subtitle: 'Bantu kami memperbaiki aplikasi',
                        onTap: () {
                          // Navigate to bug report
                        },
                      ),
                      
                      SizedBox(height: 1.5.h),
                      
                      _buildSupportOption(
                        icon: Icons.feedback,
                        title: 'Berikan Feedback',
                        subtitle: 'Saran dan masukan untuk pengembangan',
                        onTap: () {
                          // Navigate to feedback
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: cBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: cPrimaryText,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            answer,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: cBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: cPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: cPrimary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Kontak & Bantuan - Heal Me UMP',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Fallback: copy to clipboard
      // You can implement clipboard functionality here
    }
  }
}