import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

enum Sexo {
  masc, fem, other
}

@JsonSerializable()
class UserProfile {
  String nome;
  String sobrenome;
  DateTime nascimento;
  Sexo sexo;
  List<String> diagnosticos;

  UserProfile({this.nome, this.sobrenome, this.nascimento, this.sexo,
      this.diagnosticos});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}