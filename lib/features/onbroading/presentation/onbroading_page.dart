import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/router/pages_names.dart';
import 'package:healmeumpapp/router/router_navigation.dart';
import 'package:sizer/sizer.dart';

class OnbroadingPage extends StatefulWidget {
  const OnbroadingPage({super.key});

  @override
  State<OnbroadingPage> createState() => _OnbroadingPageState();
}

class _OnbroadingPageState extends State<OnbroadingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'icon': 'assets/icon-favorite.png',
      'title': 'Selamat Datang di Heal Me UMP',
      'description': 'Aplikasi untuk membantu Anda memahami kondisi Kesehatan Mental dengan tes yang terstandarisasi',
    },
    {
      'icon': 'assets/icon-brains.png',
      'title': 'Tes Kesehatan Mental',
      'description': 'Dapatkan evaluasi komprehensif dengan tes DASS-21 BDI-II untuk depresi, kecemasan dan stres',
    },
    {
      'icon': 'assets/icon-user-shield.png',
      'title': 'Privasi Terjamin',
      'description': 'Data Anda aman dan privasi terlindungi. Hasil tes hanya untuk referensi pribadi anda.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to next screen (e.g., login)
      // context.go('/login');
      RouterNavigation.router.push(PAGESNAMES.login.ScreenPath);
    }
  }

  void _skipOnboarding() {
    // Navigate to next screen (e.g., login)
    // context.go('/login');
    RouterNavigation.router.push(PAGESNAMES.login.ScreenPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Container(
                        width: 35.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          data['icon'],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      
                      // Title
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: cPrimaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      
                      // Description
                      Text(
                        data['description'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: cPrimaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      // Page indicators moved here
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            width: 3.w,
                            height: 3.w,
                            decoration: BoxDecoration(
                              color: index == _currentPage ? cPrimary : Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Bottom section with buttons only
          Padding(
            padding: EdgeInsets.only(bottom: 4.h, left: 5.w, right: 5.w),
            child: Column(
              children: [
                // Buttons
                Column(
                  children: [
                    // Selanjutnya button
                    GestureDetector(
                      onTap: _nextPage,
                      child: Container(
                        width: sWidthFull(context),
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: cPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            _currentPage == _onboardingData.length - 1 ? 'Mulai' : 'Selanjutnya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Lewati button (only show if not on last page)
                    if (_currentPage < _onboardingData.length - 1) ...[
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: _skipOnboarding,
                        child: Container(
                          width: sWidthFull(context),
                          height: 6.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: cPrimary),
                          ),
                          child: Center(
                            child: Text(
                              'Lewati',
                              style: TextStyle(
                                color: cPrimary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
