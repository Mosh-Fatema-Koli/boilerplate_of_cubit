import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/material.dart';

import '../cubit/home_cubit.dart';


class Homepage extends StatelessWidget {
   Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeMode == ThemeMode.dark;
    String formatTimeTo12Hour(String time24) {
      try {
        final time = DateFormat("HH:mm:ss").parse(time24); // or "HH:mm" if no seconds
        return DateFormat("hh:mm a").format(time); // e.g., 02:15 PM
      } catch (e) {
        return "--:-- AM";
      }
    }
    final miscController = MiscController();
    String month = "";
    String year = "";
    var date = DateTime.now(); // Current date-time
    String formattedDate = DateFormat('EEEE, dd MMM yyyy').format(date);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.w), child: RFAppBar()),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
        ],
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
         // state.success==false?  logoutController.finalLogOut(context: context, onOut: (){
         //   miscController.navigateTo(context:context,page:  LoginPage());
         // }):null;
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: 80.h,
                  color:isDark?Colors.grey: AppColors.primaryColor,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: isDark?AppColors.save_black:AppColors.bodyColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50).r,
                      topRight: Radius.circular(50).r,
                    ),
                    // border: Border.all(color: AppColors.save_black),

                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),


                  ]
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  // Expanded prestenHistory(BuildContext context, String month, String year, MiscController miscController, DashboardLoadedState state) {
  //   return Expanded(
  //                                       child: Column(
  //                                     children: [
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           RFText(
  //                                             text: "Presences History",
  //                                             size: 16.sp,
  //                                             weight: FontWeight.bold,
  //                                           ),
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               String? selectedMonth;
  //                                               String? selectedYear;
  //
  //                                               List<String> months = [
  //                                                 "January",
  //                                                 "February",
  //                                                 "March",
  //                                                 "April",
  //                                                 "May",
  //                                                 "June",
  //                                                 "July",
  //                                                 "August",
  //                                                 "September",
  //                                                 "October",
  //                                                 "November",
  //                                                 "December"
  //                                               ];
  //                                               List<String> years =
  //                                                   List.generate(
  //                                                       10,
  //                                                       (index) => (DateTime
  //                                                                       .now()
  //                                                                   .year -
  //                                                               index)
  //                                                           .toString());
  //
  //                                               showDialog(
  //                                                 context: context,
  //                                                 barrierDismissible: true,
  //                                                 builder:
  //                                                     (BuildContext context) {
  //                                                   return AlertDialog(
  //                                                     contentPadding:
  //                                                         EdgeInsets
  //                                                             .symmetric(
  //                                                                 horizontal:
  //                                                                     16),
  //                                                     content: Container(
  //                                                       height: 300.w,
  //                                                       width: 250.w,
  //                                                       child: Stack(
  //                                                         children: [
  //                                                           Column(
  //                                                             mainAxisAlignment:
  //                                                                 MainAxisAlignment
  //                                                                     .center,
  //                                                             children: [
  //                                                               Text(
  //                                                                   "Choose Option",
  //                                                                   style: TextStyle(
  //                                                                       fontSize:
  //                                                                           16.sp,
  //                                                                       fontWeight:
  //                                                                           FontWeight.bold)),
  //                                                               SizedBox(
  //                                                                   height:
  //                                                                       20.h),
  //                                                               DropdownButtonFormField<
  //                                                                   String>(
  //                                                                 value:
  //                                                                     selectedMonth,
  //                                                                 decoration: InputDecoration(
  //                                                                     labelText:
  //                                                                         "Select Month"),
  //                                                                 items: months
  //                                                                     .map((String
  //                                                                         month) {
  //                                                                   return DropdownMenuItem<
  //                                                                       String>(
  //                                                                     value:
  //                                                                         month,
  //                                                                     child: Text(
  //                                                                         month),
  //                                                                   );
  //                                                                 }).toList(),
  //                                                                 onChanged:
  //                                                                     (String?
  //                                                                         newValue) {
  //                                                                   selectedMonth =
  //                                                                       newValue;
  //                                                                   month = newValue
  //                                                                       .toString();
  //                                                                 },
  //                                                               ),
  //                                                               SizedBox(
  //                                                                   height:
  //                                                                       10.h),
  //                                                               DropdownButtonFormField<
  //                                                                   String>(
  //                                                                 value:
  //                                                                     selectedYear,
  //                                                                 decoration: InputDecoration(
  //                                                                     labelText:
  //                                                                         "Select Year"),
  //                                                                 items: years
  //                                                                     .map((String
  //                                                                         year) {
  //                                                                   return DropdownMenuItem<
  //                                                                       String>(
  //                                                                     value:
  //                                                                         year,
  //                                                                     child: Text(
  //                                                                         year),
  //                                                                   );
  //                                                                 }).toList(),
  //                                                                 onChanged:
  //                                                                     (String?
  //                                                                         newValue) {
  //                                                                   selectedYear =
  //                                                                       newValue;
  //                                                                   year = newValue
  //                                                                       .toString();
  //                                                                 },
  //                                                               ),
  //                                                               SizedBox(
  //                                                                   height:
  //                                                                       20),
  //                                                               CButton(
  //                                                                   buttonText:
  //                                                                       "Send",
  //                                                                   onTap:
  //                                                                       () {
  //                                                                     // if (year.isNotEmpty &&
  //                                                                     //     month.isNotEmpty) {
  //                                                                     //   miscController.navigateTo(
  //                                                                     //       context: context,
  //                                                                     //       page: AttendanceSummary(
  //                                                                     //         month: month,
  //                                                                     //         year: year,
  //                                                                     //       ));
  //                                                                     //   year =
  //                                                                     //       "";
  //                                                                     //   month =
  //                                                                     //       "";
  //                                                                     // } else {
  //                                                                     //   miscController.toast(
  //                                                                     //       msg: "Please select correct date and month");
  //                                                                     // }
  //                                                                   })
  //                                                             ],
  //                                                           ),
  //                                                           Positioned(
  //                                                             right: -10,
  //                                                             top: 0,
  //                                                             child:
  //                                                                 IconButton(
  //                                                               onPressed: () =>
  //                                                                   Navigator.of(
  //                                                                           context)
  //                                                                       .pop(),
  //                                                               icon: Icon(
  //                                                                   Icons
  //                                                                       .cancel,
  //                                                                   color: Colors
  //                                                                       .red),
  //                                                             ),
  //                                                           ),
  //                                                         ],
  //                                                       ),
  //                                                     ),
  //                                                   );
  //                                                 },
  //                                               );
  //                                             },
  //                                             child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                     color: Colors.white,
  //                                                     borderRadius:
  //                                                         BorderRadius
  //                                                             .circular(20).r),
  //                                                 padding:
  //                                                     EdgeInsets.symmetric(
  //                                                             vertical: 10,
  //                                                             horizontal: 20)
  //                                                         .w,
  //                                                 child: Row(
  //                                                   children: [
  //                                                     RFText(
  //                                                         text:
  //                                                             "Search Month & Year"),
  //                                                     SizedBox(
  //                                                       width: 5.w,
  //                                                     ),
  //                                                     Icon(
  //                                                       Icons.arrow_drop_down,
  //                                                       color: AppColors
  //                                                           .primaryColor,
  //                                                     )
  //                                                   ],
  //                                                 )),
  //                                           )
  //                                         ],
  //                                       ),
  //                                       SizedBox(
  //                                         height: 15.h,
  //                                       ),
  //                                       Expanded(
  //                                         child: state.dashboard
  //                                                     .currentMonthAttendance !=
  //                                                 null
  //                                             ? ListView.builder(
  //                                                 padding: EdgeInsets.zero,
  //                                                 shrinkWrap: true,
  //                                                 physics:
  //                                                     AlwaysScrollableScrollPhysics(),
  //                                                 itemCount: state
  //                                                     .dashboard!
  //                                                     .currentMonthAttendance!
  //                                                     .length,
  //                                                 itemBuilder:
  //                                                     (context, index) =>
  //                                                         Padding(
  //                                                   padding: const EdgeInsets
  //                                                           .symmetric(
  //                                                           vertical: 2).w
  //                                                       .w,
  //                                                   child: CardList(
  //                                                     attendanceHistory: state
  //                                                             .dashboard!
  //                                                             .currentMonthAttendance![
  //                                                         index],
  //                                                   ),
  //                                                 ),
  //                                               )
  //                                             : _buildEmptyState(),
  //                                       ),
  //                                     ],
  //                                   ));
  // }
  //
  // Widget _buildEmptyState() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       SizedBox(height: 32.h),
  //       Image.asset(
  //         'assets/images/empty.png',
  //         color: AppColors.primaryColor,
  //         fit: BoxFit.fitHeight,
  //         height: 30.h,
  //       ),
  //       SizedBox(height: 16.h),
  //       RFText(
  //         text: 'No data found!',
  //         weight: FontWeight.w500,
  //         size: 16.sp,
  //         color: Colors.black87.withOpacity(0.8),
  //       ),
  //       SizedBox(height: 32.h),
  //     ],
  //   );
  // }

}
