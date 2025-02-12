class Movie {
  final int id;
  final String title;
  final double rate;
  final String overview;
  final String backDropPath;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.rate,
    required this.overview,
    required this.backDropPath,
    required this.posterPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      rate: map['vote_average'],
      overview: map['overview'],
      backDropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rate': rate,
      'overview': overview,
      'backDropPath': backDropPath,
      'posterPath': posterPath
    };
  }
}

class VideoMovies {
  final String key;
  final String nameVideo;
  final String publishedAt;

  VideoMovies({
    required this.key,
    required this.nameVideo,
    required this.publishedAt,
  });

  factory VideoMovies.fromMap(Map<String, dynamic> map) {
    return VideoMovies(
      key: map['key'],
      nameVideo: map['name'],
      publishedAt: map['published_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nameVideo': nameVideo,
      'publishedAt': publishedAt,
    };
  }
}
