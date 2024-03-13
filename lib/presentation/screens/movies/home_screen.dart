import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final slideShowProvider = ref.watch(moviesSlideShowProvider);

    return Visibility(
      visible: !initialLoading,
      replacement: const FullScreenLoader(),
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            title: CustomAppbar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  MoviesSlideshow(movies: slideShowProvider),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subtitle: HumanFormat.date(DateTime.now()),
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Proximamente',
                    subtitle: 'Este mes',
                    loadNextPage: () {
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'De todos los tiempos',
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                ],
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}
