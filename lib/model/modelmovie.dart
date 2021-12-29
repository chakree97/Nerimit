import 'dart:convert';
class MovieModel{
  String? moviename;
  String? moviebackground;
  String? moviehead;
  List<String>? movietype;
  int? movierating;

  MovieModel({this.moviename,this.moviebackground,this.moviehead,this.movierating,this.movietype});
}

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));
List<MovieExpires> movieexpiresFromJson(String str) => List<MovieExpires>.from(json.decode(str).map((x) => MovieExpires.fromJson(x)));
List<MovieHistory> moviehistoryFromJson(String str) => List<MovieHistory>.from(json.decode(str).map((x) => MovieHistory.fromJson(x)));
class Movie {
    Movie({
        this.name,
        this.background,
        this.head,
        this.rating,
        this.type,
        this.view,
        this.trailer,
        this.director,
        this.actor,
        this.description,
        this.full
    });
 
    final String? name;
    final String? background;
    final String? head;
    final double? rating;
    final List<String>? type;
    final int? view;
    final String? trailer;
    final List<String>? director;
    final List<String>? actor;
    final String? description;
    final String? full;
 
    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        name: json["name"],
        background: json["background"],
        head: json["head"],
        rating: json["rating"].toDouble(),
        type: List<String>.from(json["type"].map((x) => x)),
        view: json["view"],
        trailer: json["trailer"],
        director: List<String>.from(json["director"].map((x) => x)),
        actor: List<String>.from(json["actor"].map((x) => x)),
        description: json["description"],
        full:  json["full"]
    );
}

class MovieExpires {
    MovieExpires({
        this.name,
        this.background,
        this.head,
        this.rating,
        this.type,
        this.view,
        this.trailer,
        this.director,
        this.actor,
        this.description,
        this.full,
        this.expired
    });
 
    final String? name;
    final String? background;
    final String? head;
    final double? rating;
    final List<String>? type;
    final int? view;
    final String? trailer;
    final List<String>? director;
    final List<String>? actor;
    final String? description;
    final String? full;
    final String? expired;
 
    factory MovieExpires.fromJson(Map<String, dynamic> json) => MovieExpires(
        name: json["name"],
        background: json["background"],
        head: json["head"],
        rating: json["rating"].toDouble(),
        type: List<String>.from(json["type"].map((x) => x)),
        view: json["view"],
        trailer: json["trailer"],
        director: List<String>.from(json["director"].map((x) => x)),
        actor: List<String>.from(json["actor"].map((x) => x)),
        description: json["description"],
        full:  json["full"],
        expired: json['expired']
    );
}

class MovieHistory{
     MovieHistory({
        this.name,
        this.background,
        this.head,
        this.rating,
        this.type,
        this.view,
        this.trailer,
        this.director,
        this.actor,
        this.description,
        this.full,
        this.expired,
        this.date
    });
 
    final String? name;
    final String? background;
    final String? head;
    final double? rating;
    final List<String>? type;
    final int? view;
    final String? trailer;
    final List<String>? director;
    final List<String>? actor;
    final String? description;
    final String? full;
    final String? expired;
    final String? date;
 
    factory MovieHistory.fromJson(Map<String, dynamic> json) => MovieHistory(
        name: json["name"],
        background: json["background"],
        head: json["head"],
        rating: json["rating"].toDouble(),
        type: List<String>.from(json["type"].map((x) => x)),
        view: json["view"],
        trailer: json["trailer"],
        director: List<String>.from(json["director"].map((x) => x)),
        actor: List<String>.from(json["actor"].map((x) => x)),
        description: json["description"],
        full:  json["full"],
        expired: json['expired'],
        date: json['date']
    );
}