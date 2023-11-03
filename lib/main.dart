import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saffety/screens/splash.dart';
import 'package:saffety/screens/team.dart';
import 'API/UserSimplePreferences.dart';
import 'Provider/appProvider.dart';
import 'login_screens/login.dart';
import 'package:saffety/screens/quizquestion.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(370, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AppProvider()),
          ],
          child: MaterialApp(
            supportedLocales: const [
              Locale('en'),
              Locale('el'),
              Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
              Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
            ],
            localizationsDelegates: [
              CountryLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
