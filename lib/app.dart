import 'package:currency_converter/features/converter/presentation/converter_screen.dart';
import 'package:currency_converter/utils/app_colors.dart';
import 'package:flutter/material.dart';

const _colorScheme = ColorScheme.light(surface: AppColors.primary);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency converter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
        ),

        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.outline,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.outline,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _colorScheme.secondary,
            ),
          ),
        )
      ),
      home: const ConverterScreen(),
    );
  }
}