import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/services/services.dart';

class LookAroundExercise extends HookConsumerWidget {
  const LookAroundExercise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context)!;
    final title = localization.lookAroundExercise;
    final subtitle = localization.lookAroundExerciseSubtitle;

    final appbarNotifier = ref.read(animatedAppBarProvider.notifier);

    void updateAppBar() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => appbarNotifier.updateState(
          appBarType: AppBarType.expanded,
          appBarTitle: title,
          subtitle: subtitle,
        ),
      );
    }

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.lookAroundExercise) {
          updateAppBar();
        }
      },
    );

    final titles = [
      localization.colors,
      localization.textures,
    ];

    final examples = [
      localization.colorsExamples,
      localization.texturesExamples,
    ];

    final controllers = useState<List<TextEditingController>>(
      List.generate(12, (_) => TextEditingController()),
    );

    useEffect(() {
      updateAppBar();
      return () {
        for (var controller in controllers.value) {
          controller.dispose();
        }
      };
    }, []);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                children: List.generate(
                  2,
                  (titleIndex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[titleIndex],
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: List.generate(
                            4,
                            (boxIndex) {
                              return SizedBox(
                                width: 173,
                                height: 47,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(),
                                    ),
                                    contentPadding: const EdgeInsets.all(0),
                                    counter: Offstage(),
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: controllers
                                      .value[boxIndex + titleIndex * 4],
                                  onChanged: (value) {
                                    controllers.value =
                                        List.from(controllers.value);

                                    loggerService.debug(
                                        'controllers value: ${controllers.value.map(
                                      (e) => e.text,
                                    )}');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          examples[titleIndex],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localization.continueButtonTitle,
        skip: !controllers.value.every((e) => e.text.isNotEmpty),
      ),
    );
  }
}
