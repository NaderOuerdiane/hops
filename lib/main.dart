import 'package:flutter/material.dart';
import 'package:hops/repository/hops_repository.dart';
import 'package:hops/repository/page_repository.dart';
import 'package:hops/ui/pages.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
        primaryColor: Color(0xFF2c4d4f),
        primaryColorLight: Color(0xFF699b98),
        accentColor: Color(0xFFcff5cf),
        cursorColor: Colors.yellow[900],
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c4d4f)),
            headline2: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2c4d4f)),
            headline3: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2ce8d46)),
            headline4: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              color: Color(0xFF4f858a),
              fontWeight: FontWeight.w600,
            ),
            bodyText2: TextStyle(
              color: Color(0xFF252525).withOpacity(0.6),
              fontSize: 18,
            ),
            subtitle2: TextStyle(
                fontSize: 14,
                color: Colors.orange[900],
                fontWeight: FontWeight.w600)),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<PageRepository>(
              create: (_) => PageRepository.instance()),
          ChangeNotifierProvider<HopsRepository>(
              create: (_) => HopsRepository.intsance()),
        ],
        child: PagesPage(),
      ),
    );
  }
}
