import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/calculate_exercise/providers/calc_exercise_provider.dart';

class CalcExercise extends HookConsumerWidget {
  const CalcExercise({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = AppLocalizations.of(context)!;
    final title = localization.calcExercise;
    final subtitle = localization.calcExerciseSubtitle;

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
        if (next != previous && next == RoutePaths.calculateExercise) {
          updateAppBar();
        }
      },
    );

    final focusNodes = useState<List<FocusNode>>(
      List.generate(numberOfOperations, (_) => FocusNode()),
    );

    final isAnswerCorrect = useState<List<bool>>(
      List.generate(numberOfOperations, (_) => false),
    );

    final areAllAnswersCorrect = useState<bool>(false);

    final controllers = useState<List<TextEditingController>>(
      List.generate(numberOfOperations, (_) => TextEditingController()),
    );

    useEffect(() {
      updateAppBar();
      return () {
        for (var controller in controllers.value) {
          controller.dispose();
        }

        for (var focusNode in focusNodes.value) {
          focusNode.dispose();
        }
      };
    }, []);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800,
                  ),
                  child: Column(
                    children: List.generate(
                      numberOfOperations,
                      (index) {
                        final provider = ref.watch(calcExerciseProvider);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${provider[index].firstNumber} ${provider[index].operation.displayText} ${provider[index].secondNumber} =',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: 79,
                                  height: 48,
                                  child: TextField(
                                    controller: controllers.value[index],
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: isAnswerCorrect.value[index]
                                              ? Colors.green
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: isAnswerCorrect.value[index]
                                              ? Colors.green
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      counter: Offstage(),
                                    ),
                                    maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2,
                                        ),
                                    focusNode: focusNodes.value[index],
                                    onChanged: (value) {
                                      // Update the controllers list to trigger a rebuild
                                      controllers.value =
                                          List.from(controllers.value);

                                      final correctAnswer =
                                          provider[index].result ==
                                              int.tryParse(value);

                                      // update the isAnswerCorrect list
                                      isAnswerCorrect.value[index] =
                                          correctAnswer;

                                      areAllAnswersCorrect.value =
                                          isAnswerCorrect.value.every((e) => e);

                                      // handle focus change
                                      if (correctAnswer) {
                                        if (index < 4) {
                                          focusNodes.value[index + 1]
                                              .requestFocus();
                                        } else {
                                          focusNodes.value[index].unfocus();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localization.continueButtonTitle,
          skip: !areAllAnswersCorrect.value,
        ),
      ),
    );
  }
}
