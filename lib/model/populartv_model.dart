import 'package:equatable/equatable.dart';

class Populartv_Model extends Equatable {
  final int id;
  final String? name;
  final List<dynamic> origin_country;
  final String? original_language;
  final String? original_name;
  final String? overview;
  final double? popularity;
  final String? poster_path;
  final double? vote_average;
  final int vote_count;
  final String? backdrop_path;
  final String? first_air_date;
  final List<dynamic> genre_ids;

  const Populartv_Model(
      {required this.id,
      required this.name,
      required this.origin_country,
      required this.original_language,
      required this.original_name,
      required this.overview,
      required this.popularity,
      required this.poster_path,
      required this.vote_average,
      required this.vote_count,
      required this.backdrop_path,
      required this.first_air_date,
      required this.genre_ids});

  factory Populartv_Model.fromJson(Map<String, dynamic> json) {
    return Populartv_Model(
      id: json["id"],
      name: json["name"],
      origin_country: json["origin_country"],
      original_language: json["original_language"],
      original_name: json["original_name"],
      overview: json["overview"],
      popularity: 2.0, // json["popularity"],
      poster_path: json["poster_path"],
      vote_average: 3.0, //json["vote_average"],
      vote_count: json["vote_count"],
      backdrop_path: json["backdrop_path"],
      first_air_date: json["first_air_date"],
      genre_ids: json["genre_ids"],
    );
  }
  @override
  List<Object?> get props => [
        id,
        name,
        origin_country,
        original_language,
        original_name,
        overview,
        popularity,
        poster_path,
        vote_average,
        vote_count,
        backdrop_path,
        first_air_date,
        genre_ids
      ];
}
