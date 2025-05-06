import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/extensions/date_extensions.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/models/diary_thought.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_provider.dart';
import 'package:self_help/pages/home/widgets/home_card.dart';
import 'package:self_help/services/services.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider).value;
    final title = localizations.welcomeMessage(user?.displayName ?? 'Guest');
    final subtitle = localizations.welcomeSubtitle;

    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.home,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardSosDescription,
                buttonTitle: localizations.startSosButtonTitle,
                imagePath: AssetsConstants.sosGirl,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.sosLanding.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardResilienceDescription,
                buttonTitle: localizations.startResilienceButtonTitle,
                imagePath: AssetsConstants.confidenceMan,
                onPressed: () {
                  final provider = ref.read(routerStateProvider);
                  provider.pushNamed(RoutePaths.resilience.name);
                },
              ),
              HomeCard(
                // backgroundColor: whiteGrey,
                description: localizations.homeCardTherapistDescription,
                buttonTitle: localizations.startFindATherapistButtonTitle,
                imagePath: AssetsConstants.therapist,
                onPressed: () {
                  // TODO:
                },
              ),

              // text widget
              IconButton(
                onPressed: _testPressed,
                icon: Icon(Icons.build),
              )
              // GradientFilledButton(onPressed: () {}, title: 'title'),
              // SizedBox(height: 16),
              // GradientElevatedButton(onPressed: () {}, title: 'title'),
              // SizedBox(height: 16),
              // GradientOutlinedButton(onPressed: () {}, title: 'title'),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: remove this test function, push changes and  and continue with the building a dedicated provider
  void _testPressed() async {
    await localDatabaseService.deleteAllThoughts();

    final initialThoughts = await localDatabaseService.getThoughts();

    loggerService.debug('§ initial Thoughts: $initialThoughts');

    final thought = DiaryThought(
      date: DateTime.now().dateOnly,
      content: 'this is some content',
    );

    loggerService.debug('§ new Thought: $thought');

    await localDatabaseService.saveThought(thought);

    loggerService.debug('§ Thought saved');

    final savedThought =
        await localDatabaseService.getThoughtByDate(DateTime.now().dateOnly);

    loggerService.debug('§ get Thought by date: $savedThought');

    final allThoughts = await localDatabaseService.getThoughts();
    loggerService.debug('§ all Thoughts: $allThoughts');

    await localDatabaseService.deleteThought(DateTime.now().dateOnly);

    loggerService.debug('§ Thought deleted');

    await localDatabaseService.getThoughtByDate(DateTime.now().dateOnly);

    final allThoughtsAfterDelete = await localDatabaseService.getThoughts();
    loggerService.debug('§ all Thoughts: $allThoughtsAfterDelete');
  }
}
