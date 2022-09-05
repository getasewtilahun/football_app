import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

import 'Mainscreen/mainscreen.dart';
import 'Provider/match.dart';

void main() async {
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp( ChangeNotifierProvider(create: ((context) => MatchProvider()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'G Live App',
    
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF1E2023),
            primarySwatch: const MaterialColor(0xFF131313, {
              50: Color.fromRGBO(51, 153, 255, .1),
              100: Color.fromRGBO(51, 153, 255, .2),
              200: Color.fromRGBO(51, 153, 255, .3),
              300: Color.fromRGBO(51, 153, 255, .4),
              400: Color.fromRGBO(51, 153, 255, .5),
              500: Color.fromRGBO(51, 153, 255, .6),
              600: Color.fromRGBO(51, 153, 255, .7),
              700: Color.fromRGBO(51, 153, 255, .8),
              800: Color.fromRGBO(51, 153, 255, .9),
              900: Color.fromRGBO(51, 153, 255, 1),
            }),
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const MAinScreenpage(),
    );

  }
}
