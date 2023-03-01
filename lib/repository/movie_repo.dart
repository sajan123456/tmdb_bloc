import 'package:dio/dio.dart';
import 'package:tmdb_using_bloc/api.dart';
import 'package:tmdb_using_bloc/model/movie.dart';

class MovieRepo {
  Future<List<Movie>> getMovieData() async {
    final dio = Dio();
    try {
      final response = await dio.get(Api.baseUrl, queryParameters: {
        'api_key': Api.apiKey,
      });
      // Response response = await get(Uri())

      final movieData = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();

      return movieData;
    } on DioError catch (err) {
      throw '${err.message}';
    }
  }
}
