class Actores {
  List<Actor> actores = [];

  Actores();

  Actores.fromJsonListCast(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Actor.fromJsonMapCast(item);
      actores.add(pelicula);
    }
  }
  Actores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Actor.fromJsonMap(item);
      actores.add(pelicula);
    }
  }
}

class Actor {
  String uniqueId;

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  double popularity;
  String profilePath;
  String description;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.popularity,
    this.profilePath,
    this.description,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
  Actor.fromJsonMapCast(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }
  Actor.getDescription(Map<String, dynamic> json) {
    description = json['description'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://talentclick.com/wp-content/uploads/2021/08/placeholder-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
