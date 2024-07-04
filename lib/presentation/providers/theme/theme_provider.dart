import 'package:clima_exito/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorListProvider = Provider((ref) => colorList);

final isDarkmodeProvider = StateProvider<bool>((ref) => false);

final selectedColorProvider = StateProvider<int>((ref) => 0);


final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>
((ref) => ThemeNotifier()
);


class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier(): super( AppTheme());
  
  void toggleDarkMode() {
    state = state.copyWith( isDarkmode: !state.isDarkmode );
  }

  void changeColorindex (int colorIndex) {
    state = state.copyWith( selectedColor: colorIndex );
  }
}