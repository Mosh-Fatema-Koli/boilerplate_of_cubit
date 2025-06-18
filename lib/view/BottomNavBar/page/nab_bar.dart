import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boilerplate_of_cubit/library.dart';

import '../../Calender/calender.dart';
import '../cubit/nav_state_cubit.dart';
import '../cubit/nav_state_state.dart';

class NavbarPage extends StatelessWidget {
  final int initialIndex;
   NavbarPage({Key? key, required this.initialIndex}) : super(key: key);

  final List<Widget> pages =  [
    Homepage(),
    ProfilePage(),
    CalenderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(initialIndex),
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, navState) {
          final themeCubit = context.watch<ThemeCubit>();
          final isDark = themeCubit.state.themeMode == ThemeMode.dark;

          return WillPopScope(
            onWillPop: () async {
              await MiscController().showAppExitDialog(context: context);
              return false;
            },
            child: Stack(
              children: [
                Scaffold(
                  body: PageView(
                    controller: navState.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages,
                  ),
                  // floatingActionButton: _buildFloatingActionButton(context),
                  // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: BottomAppBar(
                    height: 70.w,
                    color: isDark ? AppColors.greyColor : AppColors.save_white,
                    elevation: 20,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 10.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavBarItem(context, 0, Icons.home, 'home'.tr(context)),
                        // Column(
                        //   children: [
                        //     SizedBox(height: 23.h),
                        //     RFText(text: 'camera'.tr(context), size: 14.sp, textAlign: TextAlign.center),
                        //   ],
                        // ),
                        _buildNavBarItem(context, 1, Icons.person, 'profile'.tr(context)),
                        _buildNavBarItem(context, 2, Icons.calendar_month, 'calender'.tr(context)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () async {
        // final misc = MiscController();
        // SharedPreferences pref = await misc.pref();
        // final checkIn = misc.prefGetString(pref: pref, key: Constant.checkIn) ?? "";
        // final checkOut = misc.prefGetString(pref: pref, key: Constant.checkOut) ?? "";
        //
        // if (checkIn == "null") {
        //   misc.navigateTo(context: context, page: CheckIn(checkIn: true));
        // } else if (checkOut == "null") {
        //   misc.navigateTo(context: context, page: CheckIn(checkIn: false));
        // } else {
        //   misc.toast(msg: "Already Submitted", position: ToastGravity.BOTTOM);
        // }
      },
      elevation: 10,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/img.png", fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context, int index, IconData icon, String label) {
    final navCubit = context.read<NavCubit>();
    final selectedIndex = navCubit.state.index;
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeMode == ThemeMode.dark;

    final activeColor = isDark ? AppColors.save_white : Colors.black;
    final inactiveColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final color = selectedIndex == index ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: () => navCubit.changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 25.w, color: color),
          RFText(text: label, size: 14.sp, color: color),
        ],
      ),
    );
  }
}
