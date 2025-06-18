
import 'package:flutter/cupertino.dart';
import '../../../library.dart';
import 'nav_state_state.dart';


class NavCubit extends Cubit<NavState> {
  NavCubit(int initialIndex) : super(NavState(
    index: initialIndex,
    pageController: PageController(initialPage: initialIndex),
  ));


  void changeTab(int newIndex) {
    state.pageController.jumpToPage(newIndex);
    emit(NavState(index: newIndex, pageController: state.pageController));
  }
}
