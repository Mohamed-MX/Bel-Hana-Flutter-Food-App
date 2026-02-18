import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'presentation/home/home_viewmodel.dart';
import 'presentation/trending/trending_screen.dart';
import 'presentation/trending/trending_viewmodel.dart';
import 'presentation/track_order/track_order_screen.dart';
import 'presentation/main_shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => TrendingViewModel()),
      ],
      child: MaterialApp(
        title: 'تطبيق توصيل الطعام',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // Enable RTL for Arabic
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const MainShell(),
        routes: {
          '/trending': (context) => const TrendingScreen(),
          '/track-order': (context) => const TrackOrderScreen(),
        },
      ),
    );
  }
}
