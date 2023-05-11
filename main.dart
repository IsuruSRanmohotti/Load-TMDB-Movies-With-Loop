import 'dart:convert';

import 'package:http/http.dart';

Future<(List<Movie>, int)> getData({int page = 1}) async {
  final apiKey = "?api_key=<<<<<<<YOUR TMDB API KEY>>>>>>>";
  final url = "https://api.themoviedb.org/3/movie/popular";

  Response response = await get(Uri.parse("$url$apiKey&page=$page"));
  Map<String, dynamic> data = jsonDecode(response.body);
  List<dynamic> results = data['results'];
  int pages = data['total_pages'];
  List<Movie> movies = results.map((e) {
    return Movie.fromJson(e);
  }).toList();
  return (movies, pages);
}

Future<void> main() async {
  var (movies, pages) = await getData();
  for (int i = 1; i < pages; i++) {
    for (int n = 0; n < 20; n++) {
      print(movies[n].title);
    }
    (movies, pages) = await getData(page: i);
  }
}

class Movie {
  String? title;
  Movie({this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(title: json['title']);
  }
}
