import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_widgets/flow_drawer.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/pages/magic_touch/providers/magic_touch_provider.dart';
import 'package:self_help/pages/magic_touch/widgets/butterfly_hug.dart';
import 'package:self_help/pages/magic_touch/widgets/calming_hug.dart';
import 'package:self_help/services/logger_service.dart';

class MagicTouch extends HookConsumerWidget {
  const MagicTouch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final provider = ref.watch(magicTouchProvider);
    final notifier = ref.read(magicTouchProvider.notifier);

    LoggerService.debug('timer on $provider');

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        // if (didPop) {
        //   ref.read(pageFlowProvider.notifier).didPop();
        // }
      },
      child: Scaffold(
        // appBar: FlowAppBar(
        //   title: localizations.magicTouch,
        //   subtitle: localizations.magicTouchSubtitle,
        // ),
        body: SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'חיבוק פרפר'),
                    Tab(text: 'מגע מרגיע'),
                  ],
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  labelColor: Theme.of(context).primaryColor,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withAlpha(50),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: 380,
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ButterflyHug(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CalmingHug(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  width: 160,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                    ),
                    // toggle timer
                    onPressed: () => notifier.toggleTimer(),
                    child: Row(
                      children: [
                        Expanded(
                          child: !provider.isActive
                              ? Text(
                                  'התחל',
                                  textAlign: TextAlign.center,
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Text('$provider'),
                                    ),
                                    Text('שניות'),
                                    SizedBox(width: 16),
                                  ],
                                ),
                        ),
                        Transform.flip(
                          flipX: true,
                          child: Icon(
                            provider.isActive ? Icons.stop : Icons.play_arrow,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.continueButtonTitle,
          skip: provider.isFinished,
        ),
        drawer: FlowDrawer(),
      ),
    );
  }
}
