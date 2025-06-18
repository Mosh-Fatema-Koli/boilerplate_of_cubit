import 'package:boilerplate_of_cubit/view/Profile/cubit/translation/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';

import 'cubit/translation/app_language_cubit.dart';



class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final MiscController miscController = MiscController();
  final logoutController = LoginRepository();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: isDark
            ? BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        )
            : BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.appbarColor,
              AppColors.bodyColor,
              AppColors.bodyColor,
              AppColors.bodyColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  height: 120.h,
                  width: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  padding: EdgeInsets.all(5).w,
                  child: ClipOval(
                    child: Image.asset("assets/images/man.png", fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 10.h),

                // User Info
                RFText(
                  text: AppCache().userInfo?.fullName ?? "Not Found",
                  weight: FontWeight.bold,
                  size: 18.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
                RFText(
                  text: AppCache().userInfo?.email ?? "Not Found",
                  color: isDark ? Colors.white : Colors.black,
                ),
                RFText(
                  text: "Phone: ${AppCache().userInfo?.phoneNumber ?? "Not Found"}",
                  color: isDark ? Colors.white : Colors.black,
                ),
                SizedBox(height: 20.h),

                // Update Profile
                _buildCard(
                  context: context,
                  icon: Icons.person,
                  label: "Update Profile",
                  onTap: () => miscController.navigateTo(
                    context: context,
                    page: UpdateProfile(userInfo: AppCache().userInfo!),
                  ),
                ),

                // Language
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5).w,
                  child: Card(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    elevation: 5,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).w,
                      ),
                      tileColor: isDark ? Colors.grey[850] : Colors.white,
                      leading: Icon(Icons.g_translate_outlined, size: 18.w,),
                      title: RFText(text: 'language_setting'.tr(context),color:!isDark ? Colors.grey[850] : Colors.white ,),
                      trailing: DropdownButton<String>(
                        underline: const SizedBox(),
                        value: context.watch<AppLanguageCubit>().state.locale.languageCode,
                        icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.white : Colors.black),
                        dropdownColor: isDark ? Colors.grey[800] : Colors.white,
                        items: [
                          DropdownMenuItem(value: 'en', child: RFText(text: 'English',color: isDark ? Colors.white : Colors.black,)),
                          DropdownMenuItem(value: 'bn', child: RFText(text: 'Bengali',color: isDark ? Colors.white : Colors.black,)),
                        ],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            context.read<AppLanguageCubit>().changeLanguage(
                              languageCode: newValue,
                              context: context,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                // Theme Switch
                _buildCard(
                  context: context,
                  icon: Icons.dark_mode,
                  label: isDark ? "Switch to Light Theme" : "Switch to Dark Theme",
                  onTap: () => themeCubit.toggleTheme(),
                ),

                // Change Password
                _buildCard(
                  context: context,
                  icon: Icons.password,
                  label: "Change Password",
                  onTap: () => miscController.navigateTo(
                    context: context,
                    page: PasswordChange(),
                  ),
                ),

                // Logout
                _buildCard(
                  context: context,
                  icon: Icons.logout,
                  label: "Sign-Out",
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Confirm Sign-Out"),
                        content: const Text("Are you sure you want to sign out?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Sign Out"),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      logoutController.logout(
                        context: context,
                        onLogout: () {
                          miscController.navigateTo(context: context, page: SplashPage());
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable Card
  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5).w,
      child: Card(
        color: isDark ? Colors.grey[850] : Colors.white,
        elevation: 5,
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: isDark ? Colors.white : Colors.black),
          title: RFText(text: label, color: isDark ? Colors.white : Colors.black),
          trailing: Icon(Icons.arrow_forward_ios, size: 20, color: isDark ? Colors.white54 : Colors.black54),
        ),
      ),
    );
  }
}

