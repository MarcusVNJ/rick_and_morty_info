import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/http/http_client.dart'
    show IHttpClient;
import 'package:rick_and_morty_info/external/datasources/rick_and_morty_remote_data_source.dart';
import 'package:rick_and_morty_info/external/model/character_dto.dart';

class RickAndMortyRemoteDataSourceImpl implements RickAndMortyRemoteDataSource {
  final IHttpClient client;

  RickAndMortyRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterDto>> getAllCharacters() async {
    try {
      final response = await client.get('/character');
      final characters = response.data['results'] as List;

      return characters.map((characterJson) => CharacterDto.fromJson(characterJson)).toList();
    } on RequestFailure {
      rethrow;
    }
  }
}
