import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-ES',
      },
    ),
  );

  Future<List<Movie>> _getMovieEntities(
      {required String url, int page = 1}) async {
    final response = await dio.get(url, queryParameters: {'page': page});

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> moviesList = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.movieDBToEntity(movieDB))
        .toList();

    return moviesList;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async =>
      await _getMovieEntities(url: '/movie/now_playing', page: page);

  @override
  Future<List<Movie>> getPopular({int page = 1}) async =>
      await _getMovieEntities(url: '/movie/popular', page: page);

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async =>
      await _getMovieEntities(url: '/movie/top_rated', page: page);

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async =>
      await _getMovieEntities(url: '/movie/upcoming', page: page);
}
