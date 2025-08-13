import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/model/character.dart';

abstract class CharacterRepository {
  Future<Either<RequestFailure, List<Character>>> getAllCharacters();
}