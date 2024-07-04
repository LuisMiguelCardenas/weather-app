import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/presentation/providers/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme-changer-screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
              onPressed: () {

                // ref.read(isDarkmodeProvider.notifier).update((state) => !state);

                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
              },
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined))
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {

    final List<Color> colors = ref.watch( colorListProvider);
    final selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];


        return RadioListTile(
          title: Text(getColorName(color.value), style: TextStyle(color: color)),
          activeColor: color,
          value: index, 
          groupValue: selectedColor, 
          onChanged: (value) {

            ref.read(themeNotifierProvider.notifier).changeColorindex(index);
          }
          );
      },
    );
  }
}


