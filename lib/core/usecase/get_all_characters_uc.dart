import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/model/character.dart';
import 'package:rick_and_morty_info/core/repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository _repository;

  GetAllCharacters(this._repository);

  Future<Either<RequestFailure, List<Character>>> execute() async {
    return await _repository.getAllCharacters();
  }
}
