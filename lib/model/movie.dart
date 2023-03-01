class Movie {
  final int id;
  final String title;
  final String poster_path;

  Movie({required this.id, required this.poster_path, required this.title});

  factory Movie.empty() {
    return Movie(
      id: 0,
      poster_path: '',
      title: '',
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      poster_path:
          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${json['poster_path']}',
      title: json['title'],
    );
  }
}
