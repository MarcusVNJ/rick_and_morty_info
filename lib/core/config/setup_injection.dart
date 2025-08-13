import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_info/application/viewmodel/home_view_model.dart';
import 'package:rick_and_morty_info/core/config/configs.dart';
import 'package:rick_and_morty_info/core/http/http_client.dart';
import 'package:rick_and_morty_info/core/repositories/character_repository.dart';
import 'package:rick_and_morty_info/core/usecase/get_all_characters_uc.dart';
import 'package:rick_and_morty_info/external/datasources/rick_and_morty_remote_data_source.dart';
import 'package:rick_and_morty_info/external/datasources/rick_and_morty_remote_data_source_impl.dart';
import 'package:rick_and_morty_info/external/dio/dio_adapter.dart';
import 'package:rick_and_morty_info/external/repositories/character_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  getIt.registerSingleton<Dio>(_getDio());

  getIt.registerLazySingleton<IHttpClient>(() => DioAdapter(dio: getIt<Dio>()));

  getIt.registerLazySingleton<RickAndMortyRemoteDataSource>(
    () => RickAndMortyRemoteDataSourceImpl(client: getIt<IHttpClient>()),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: getIt<RickAndMortyRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetAllCharacters>(
    () => GetAllCharacters(getIt<CharacterRepository>()),
  );

  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(getAllCharacters: getIt<GetAllCharacters>()),
  );
}


Dio _getDio() {
  final options = BaseOptions(
    baseUrl: Configs.apiInfo['path'],
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );
  return Dio(options);
}
