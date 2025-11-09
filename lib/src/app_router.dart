import 'package:flutter_marvel_characters/src/modules/characters/presentation/pages/characters_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: ( context,  state) {
        return const CharactersPage();
      },
      routes: <RouteBase>[
        // ==========================================================
        // Rota 1: Characters Details Page (Root Path)
        // ==========================================================
        // GoRoute(
        //   path: 'character/:id',
        //   builder: (context, state) {
        //     final characterId = int.parse(state.pathParameters['id']!);
        //     return CharacterDetailsPage(characterId: characterId);
        //   },
        // ),
      ],
    ),
  ],
  // errorBuilder: (context, state) => Scaffold(
  //   body: Center(
  //     child: Text('Error: ${state.error}'),
  //   ),
  // ),
);
