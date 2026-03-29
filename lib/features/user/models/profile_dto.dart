import 'dart:convert';

ProfileDto profileDtoFromJson(String str) =>
    ProfileDto.fromJson(json.decode(str));

String profileDtoToJson(ProfileDto data) => json.encode(data.toJson());

class ProfileDto {
  User? user;

  ProfileDto({this.user});

  ProfileDto copyWith({User? user}) => ProfileDto(user: user ?? this.user);

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? email;
  String? name;

  User({this.id, this.email, this.name});

  User copyWith({String? id, String? email, String? name}) => User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
      };
}
