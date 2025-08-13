import 'package:rick_and_morty_info/external/model/character_dto.dart';

abstract class RickAndMortyRemoteDataSource {
  Future<List<CharacterDto>> getAllCharacters();
}
