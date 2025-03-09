import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/core/theme.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/calculate_exercise/providers/calc_exercise_provider.dart';
import 'package:self_help/services/services.dart';

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

    final isValid = useState(false);

    final focusNodes = useState<List<FocusNode>>(
      List.generate(5, (_) => FocusNode()),
    );

    final controllers = useState<List<TextEditingController>>(
      List.generate(5, (_) => TextEditingController()),
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

    return Scaffold(
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
                    5,
                    (index) {
                      final provider = ref.watch(calcExerciseProvider);

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${provider[index].firstNumber} ${provider[index].operation.displayText} ${provider[index].secondNumber} =',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ),
                              Container(
                                width: 79,
                                height: 48,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: provider[index].result ==
                                          int.tryParse(
                                              controllers.value[index].text)
                                      ? correctAnswerColor
                                      : wrongAnswerColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: controllers.value[index],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(0),
                                    counter: Offstage(),
                                  ),
                                  maxLength: 2,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  focusNode: focusNodes.value[index],
                                  onChanged: (value) {
                                    controllers.value =
                                        List.from(controllers.value);

                                    if (provider[index].result ==
                                        int.tryParse(value)) {
                                      loggerService.debug('correct');
                                      // focus on next node
                                      if (index < 4) {
                                        focusNodes.value[index + 1]
                                            .requestFocus();
                                      } else {
                                        isValid.value = true;
                                        focusNodes.value[index].unfocus();
                                      }
                                    } else {
                                      loggerService.debug('incorrect');
                                      isValid.value = false;
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
        skip: !isValid.value,
      ),
    );
  }
}
