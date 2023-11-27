class User {
  String? gender;
  Name? name;
  Location? location;
  String? email;
  String? cell;
  Id? id;
  Picture? picture;
  User(
      this.gender,
        this.name,
        this.location,
        this.email,
        this.cell,
        this.id,
        this.picture);

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    email = json['email'];
    cell = json['cell'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    picture =
    json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toMap(){
    return {
      'id_name': id!.name!, // Cambiar a id!.value o el tipo de dato que sea apropiado
      'id_value':id!.value!,
      'firstName': name!.first!,
      'lastName': name!.last!,
      'title': name!.title!,
      'email': email,
      'location': location!.city!,
      'cell': cell,
      'picture': picture!.thumbnail!,
      'gender': gender,
    };
  }

}

class Name {
  String? title;
  String? first;
  String? last;

  Name(this.title, this.first, this.last);

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}

class Location {
  String? city;

  Location(
        this.city);

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }
}

class Id {
  String? name;
  String? value;

  Id(this.name, this.value);

  Id.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}


class Picture {
  String? thumbnail;

  Picture(this.thumbnail);

  Picture.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
  }
}