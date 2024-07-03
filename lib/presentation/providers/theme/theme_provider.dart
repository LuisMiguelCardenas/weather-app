import 'package:clima_exito/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:widges_app/config/theme/app_them.dart';

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

//Un simple booleano
final isDarkmodeProvider = StateProvider<bool>((ref) => false);

//Un simple int
final selectedColorProvider = StateProvider<int>((ref) => 0);





//Un objeto de tipo Apptheme custom
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