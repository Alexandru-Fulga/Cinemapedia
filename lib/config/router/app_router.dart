import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/home_views/home_view.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(childView: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: '/',
                builder: (context, state) {
                  return const HomeView();
                },
                routes: [
                  GoRoute(
                    path: 'movie/:id',
                    name: MovieScreen.name,
                    builder: (context, state) {
                      final movieId = state.pathParameters['id'] ?? 'no-id';
                      return MovieScreen(movieId: movieId);
                    },
                  ),
                ])
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/popular',
              builder: (context, state) => const PopularView(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            )
          ],
        ),
      ],
    )
  ],
);
