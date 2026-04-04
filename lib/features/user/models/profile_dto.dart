import 'dart:convert';

ProfileDto profileDtoFromJson(String str) =>
    ProfileDto.fromJson(json.decode(str));

String profileDtoToJson(ProfileDto data) => json.encode(data.toJson());

class ProfileDto {
  String? id;
  String? email;
  String? name;

  ProfileDto({this.id, this.email, this.name});

  ProfileDto copyWith({String? id, String? email, String? name}) => ProfileDto(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
  );

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      ProfileDto(id: json["id"], email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "email": email, "name": name};
}
