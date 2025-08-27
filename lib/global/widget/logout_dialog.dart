import 'package:flutter/material.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:sizer/sizer.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback? onLogout;
  final VoidCallback? onCancel;
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;

  const LogoutDialog({
    super.key,
    this.onLogout,
    this.onCancel,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Section
          Container(
            width: 20.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout_rounded,
              color: Colors.red[600],
              size: 25.sp,
            ),
          ),
          SizedBox(height: 2.h),

          // Title
          Text(
            title ?? 'Keluar dari Aplikasi',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: cPrimaryText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),

          // Message
          Text(
            message ?? 'Apakah Anda yakin ingin keluar dari aplikasi?',
            style: TextStyle(
              fontSize: 14.sp,
              color: cPrimaryText,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),

          // Buttons
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onCancel?.call();
                  },
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cancelText ?? 'Batal',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),

              // Logout Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onLogout?.call();
                  },
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        confirmText ?? 'Keluar',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Static method untuk memudahkan penggunaan
  static Future<bool?> show({
    required BuildContext context,
    VoidCallback? onLogout,
    VoidCallback? onCancel,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return LogoutDialog(
          onLogout: onLogout,
          onCancel: onCancel,
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
        );
      },
    );
  }
}

// Extension untuk memudahkan penggunaan di StatelessWidget
extension LogoutDialogExtension on BuildContext {
  Future<bool?> showLogoutDialog({
    VoidCallback? onLogout,
    VoidCallback? onCancel,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
  }) {
    return LogoutDialog.show(
      context: this,
      onLogout: onLogout,
      onCancel: onCancel,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
    );
  }
}
