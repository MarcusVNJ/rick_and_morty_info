import 'package:rick_and_morty_info/core/model/character.dart';

class CharacterDto extends Character {
  CharacterDto({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.imageUrl,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      imageUrl: json['image'],
    );
  }
}
