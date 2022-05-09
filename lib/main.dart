import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scan/filial.dart';
import 'package:scan/provider.dart';
import 'package:scan/regist.dart';
import 'package:scan/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FilialInfo>(
        create: (context) => FilialInfo(),
        child: LayoutBuilder(builder: (context, constraints) {
          return LayoutBuilder(builder: (context, constraints) {
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: (_) {
                  return MaterialApp(
                      theme: ThemeData(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      debugShowCheckedModeBanner: false,
                      routes: {
                        'main_screen': (BuildContext context) => const Filial(),
                        'reg': (BuildContext context) => const Reg()
                      },
                      initialRoute: 
                      UserSimplePreferences.getName() == null ?
                      'reg':
                      'main_screen'
                      );
                });
          });
        }));
  }
}
