
import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeRepository = ThemeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(themeRepository)),
        BlocProvider(create: (_) => AppLanguageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 830),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return BlocBuilder<AppLanguageCubit, AppLanguageState>(
            builder: (context, langState) {
              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  return MaterialApp(
                    locale: langState.locale,
                    supportedLocales: const [
                      Locale('en'),
                      Locale('bn'),
                    ],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      if (deviceLocale == null) return supportedLocales.first;
                      return supportedLocales.firstWhere(
                            (locale) => locale.languageCode == deviceLocale.languageCode,
                        orElse: () => supportedLocales.first,
                      );
                    },
                    themeMode: themeState.themeMode,
                    theme: ThemeData.light(),
                    darkTheme: ThemeData.dark(),
                    home: SplashPage(),
                    title: 'Tasks',
                    debugShowCheckedModeBanner: false,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


//stable