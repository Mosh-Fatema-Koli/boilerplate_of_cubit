
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_localization.dart';
import 'language_helper.dart';
part 'app_language_state.dart';



class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageState( locale: const Locale('en'))){
    getSavedLanguage();
  }


 getSavedLanguage() async {
    final String cachedLanguageCode = await LanguageHelper().getCachedLanguageCode();
    print(cachedLanguageCode);
    emit(AppLanguageState(locale: Locale(cachedLanguageCode)));
  }



 changeLanguage({required String languageCode ,required BuildContext context}) async {
    print(languageCode);
    await LanguageHelper().saveLanguageCode(languageCode);
    emit(AppLanguageState(locale: Locale(languageCode)));

    // emit(AppLocalizations.delegate.load( Locale(languageCode)) as AppLanguageState);
     AppLocalizations.of(context)?.loadJsonLanguage(Locale(languageCode));
  }
}