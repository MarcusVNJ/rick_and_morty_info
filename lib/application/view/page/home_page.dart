import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_info/application/view/page/components/error_modal_content.dart';
import 'package:rick_and_morty_info/application/view/theme/rick_colors.dart';
import 'package:rick_and_morty_info/application/view/ui/rick_text.dart';
import 'package:rick_and_morty_info/application/viewmodel/home_view_model.dart';
import 'package:rick_and_morty_info/core/enum/view_model_process_state.dart';
import 'package:rick_and_morty_info/core/error/request_failures.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';


class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (widget.viewModel.characters.value.isEmpty) {
      widget.viewModel.fetchCharacters();
    }

    effect(() {
      final error = widget.viewModel.error.value;
      final stateError = widget.viewModel.processState.value == ViewModelProcessState.error;

      if (!stateError) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        final (icon, message) = switch (error) {
          NoConnectionError() => (Icons.wifi_off_outlined, error.message),
          TimeOutError() => (Icons.timer_off_outlined, error.message),
          RequestCancelledError() => (Icons.cancel_outlined, error.message),
          _ => (Icons.error_outline, error!.message),
        };

        _showErrorModal(
          context: context,
          message: message,
          icon: icon,
          onRetry: widget.viewModel.fetchCharacters,
        );
      });
    });
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
      elevation: 2.0,
      title: SvgPicture.asset(
        'assets/images/rick_and_morty.svg',
        height: 40,
        colorFilter: const ColorFilter.mode(
          RickColors.white,
          BlendMode.srcIn,
        ),
      ),
      centerTitle: true,
    ),
      body: Watch((context) {
        final showSkeleton =
            widget.viewModel.processState.value == ViewModelProcessState.loading;

        return Skeletonizer(
          enabled: showSkeleton,
          effect: ShimmerEffect(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: RickColors.background,
          ),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            itemCount: showSkeleton
                ? 8
                : widget.viewModel.characters.value.length,
            itemBuilder: (context, index) {
              final character = showSkeleton
                  ? null
                  : widget.viewModel.characters.value[index];
              final imageSize = screenWidth * 0.22;
              final horizontalPadding = screenWidth * 0.04;

              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: screenWidth * 0.02,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (character != null) {
                      context.push('/details', extra: character);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            character?.imageUrl ?? '',
                            height: imageSize,
                            width: imageSize,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                height: imageSize,
                                width: imageSize,
                                child: const Icon(
                                  Icons.error_outline,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: horizontalPadding),
                        Expanded(
                          child: RickText(
                            character?.name ?? 'Character Name',
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  void _showErrorModal({
    required BuildContext context,
    required String message,
    required VoidCallback onRetry,
    required IconData icon,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return ErrorModalContent(
          message: message,
          onRetry: onRetry,
          icon: icon,
        );
      },
    );
  }
}
