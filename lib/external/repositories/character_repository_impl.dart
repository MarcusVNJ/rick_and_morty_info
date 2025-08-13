import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/model/character.dart';
import 'package:rick_and_morty_info/core/repositories/character_repository.dart';
import 'package:rick_and_morty_info/external/datasources/rick_and_morty_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final RickAndMortyRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<RequestFailure, List<Character>>> getAllCharacters() async {
    try {
      final characterModels = await remoteDataSource.getAllCharacters();
      return Right(characterModels);
    } on RequestFailure catch (failure){
      return Left(failure);
    }
  }
}
