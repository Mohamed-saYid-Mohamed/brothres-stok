import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSectionHeader('Account Settings'),
          _buildSettingsTile(Icons.person_outline, 'Edit Profile'),
          _buildSettingsTile(Icons.lock_outline, 'Change Password'),
          _buildSettingsTile(
            Icons.notifications_outlined,
            'Notification Settings',
          ),
          SizedBox(height: 24.h),
          _buildSectionHeader('App Preferences'),
          _buildSettingsTile(Icons.language, 'Language Settings'),
          _buildSettingsTile(Icons.dark_mode_outlined, 'Appearance'),
          SizedBox(height: 24.h),
          _buildSectionHeader('More Info'),
          _buildSettingsTile(Icons.privacy_tip_outlined, 'Privacy Policy'),
          _buildSettingsTile(Icons.description_outlined, 'Terms & Conditions'),
          _buildSettingsTile(
            Icons.info_outline,
            'App Version',
            trailing: '1.0.0',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, {String? trailing}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.secondary),
        title: Text(title),
        trailing: trailing != null
            ? Text(trailing, style: const TextStyle(color: Colors.grey))
            : const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
      ),
    );
  }
}
