import 'package:clima_exito/presentation/providers/theme/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clima_exito/config/router/app_router.dart';
import 'package:clima_exito/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future <void> main() async {

  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {

       final AppTheme appTheme = ref.watch( themeNotifierProvider );
    
    
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
    );
  }
}
