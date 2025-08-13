import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_info/application/view/page/character_details_page.dart';
import 'package:rick_and_morty_info/application/view/page/home_page.dart';
import 'package:rick_and_morty_info/application/viewmodel/home_view_model.dart';
import 'package:rick_and_morty_info/core/model/character.dart';


final routers = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(
        viewModel: GetIt.I<HomeViewModel>(),
      ),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final character = state.extra as Character;
        return CharacterDetailsPage(character: character);
      },
    ),
  ],
);