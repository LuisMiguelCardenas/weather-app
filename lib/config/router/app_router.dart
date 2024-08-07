import 'package:clima_exito/presentation/screens/cities_screen.dart';
import 'package:clima_exito/presentation/screens/city_description_screen.dart';
import 'package:clima_exito/presentation/screens/home_screen.dart';
import 'package:clima_exito/presentation/screens/theme_changer_screen.dart';
import 'package:clima_exito/presentation/widgets/shared/custom_buottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return CostomBottomNavigation(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (
                BuildContext context,
                GoRouterState state,
              ) =>
                  const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/cities',
              builder: (
                BuildContext context,
                GoRouterState state,
              ) =>
                  const CitiesScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'city/:name',
                  builder: (context, state) {
                    final cityName = state.pathParameters['name'] ?? 'no-id';
                    // final cityName = state.pathParameters['name'] ?? 'no-name';
                    return CityDescriptionScreen(cityName: cityName);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/theme',
              builder: (
                BuildContext context,
                GoRouterState state,
              ) =>
                  const ThemeChangerScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
