import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/application/view/ui/rick_button.dart';
import 'package:rick_and_morty_info/application/view/ui/rick_text.dart';

class ErrorModalContent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  const ErrorModalContent({
    super.key,
    required this.message,
    required this.onRetry,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 80,
          ),
          const SizedBox(height: 20),
          RickText(
            'Wubba Lubba Dub Dub!',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          RickText(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          RickButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry();
            },
            text: 'Tentar Novamente',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
