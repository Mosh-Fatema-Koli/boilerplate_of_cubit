
import 'package:boilerplate_of_cubit/library.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial(needLogin: false,success: false,message: "")){
    loginApiCall();
  }

  final _loginRepository = LoginRepository();
  final _miscController = MiscController();

  loginApiCall() async {
    SharedPreferences pref = await _miscController.pref();
    final userInfoString = _miscController.prefGetString(pref: pref, key: Constant.userInfoPref);
    UserInfo userInfo = (userInfoString != null && userInfoString.isNotEmpty)
        ? UserInfo.fromJson(jsonDecode(userInfoString))
        : UserInfo();
    userInfo = AppCache(userInfo: userInfo).userInfo!;
    String? username = userInfo.username;
    await _miscController.delayed(millisecond: 3000);
    if(username != null && username.isNotEmpty){
     emit(SplashInitial(needLogin: false, success: true, message: "message",));
    } else {
      emit(SplashInitial(needLogin: true, success: false, message: '', ));
    }
  }

}
