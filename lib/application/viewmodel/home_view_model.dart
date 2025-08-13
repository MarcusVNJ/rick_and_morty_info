import 'package:rick_and_morty_info/core/enum/view_model_process_state.dart';
import 'package:rick_and_morty_info/core/usecase/get_all_characters_uc.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:rick_and_morty_info/core/model/character.dart';

class HomeViewModel {
  final GetAllCharacters _getAllCharacters;
  final Signal<List<Character>> characters;
  final Signal<RequestFailure?> error;
  final Signal<ViewModelProcessState> processState;

  HomeViewModel({required GetAllCharacters getAllCharacters})
    : _getAllCharacters = getAllCharacters,
      characters = signal<List<Character>>([]),
      error = signal<RequestFailure?>(null),
      processState = signal<ViewModelProcessState>(ViewModelProcessState.initial);

  Future<void> fetchCharacters() async {
    processState.value = ViewModelProcessState.loading;

    final response = await _getAllCharacters.execute();

    response.fold(
      (failure) {
        error.value = failure;
        processState.value = ViewModelProcessState.error;
      },
      (characterList) {
        characters.value = characterList;
        processState.value = ViewModelProcessState.success;
      },
    );
  }

  void dispose() {
    characters.dispose();
    error.dispose();
  }
}
