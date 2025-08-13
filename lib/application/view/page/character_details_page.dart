import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/application/view/theme/rick_colors.dart';
import 'package:rick_and_morty_info/application/view/ui/rick_text.dart';
import 'package:rick_and_morty_info/core/model/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  final Character character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: RickText(character.name), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width * 0.7,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RickText(
                  'Informações',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.rocket_launch,
                                color: RickColors.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: 16),
                              RickText(
                                'Espécie',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: RickColors.textSecondary),
                              ),
                              const Spacer(),
                              RickText(
                                character.species,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: RickColors.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: 16),
                              RickText(
                                'Status',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: RickColors.textSecondary),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: getStatusColor(),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  RickText(
                                    character.status,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor() {
    switch (character.status.toLowerCase()) {
      case 'alive':
        return RickColors.statusAlive;
      case 'dead':
        return RickColors.statusDead;
      default:
        return RickColors.statusUnknown;
    }
  }
}
