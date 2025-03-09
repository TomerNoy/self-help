import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/services/services.dart';

class RepeatNumber extends HookConsumerWidget {
  const RepeatNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final title = localizations.enterNumber;
    final subtitle = localizations.enterNumberSubtitle;

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

    final orderedController = useTextEditingController();
    final reversedController = useTextEditingController();

    final orderedFocusNode = useFocusNode();
    final reversedFocusNode = useFocusNode();

    ref.listen(
      routerListenerProvider,
      (previous, next) {
        if (next != previous && next == RoutePaths.repeatNumber) {
          updateAppBar();
        }
      },
    );

    final String orderedRandomNumber = useMemoized(
      () => generateRandom(),
    );

    final String reversedRandomNumber =
        orderedRandomNumber.split('').reversed.join();

    final orderedInputValid = useState(false);
    final reversedInputValid = useState(false);

    useEffect(() {
      updateAppBar();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(orderedFocusNode);
      });
      return null;
    }, []);

    final orderedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: orderedInputValid.value ? Colors.green : Colors.grey,
      ),
    );
    final reversedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: reversedInputValid.value ? Colors.green : Colors.grey,
      ),
    );

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enter the number you see below',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16),
                    Text(
                      orderedRandomNumber,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            letterSpacing: 10,
                          ),
                    ),
                    SizedBox(height: 16),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextField(
                        controller: orderedController,
                        focusNode: orderedFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(letterSpacing: 10),
                        decoration: InputDecoration(
                          counter: Offstage(),
                          enabledBorder: orderedBorder,
                          focusedBorder: orderedBorder,
                        ),
                        onChanged: (value) {
                          if (value == orderedRandomNumber) {
                            FocusScope.of(context)
                                .requestFocus(reversedFocusNode);
                            orderedInputValid.value = true;
                          } else {
                            orderedInputValid.value = false;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Now enter the number in reverse order',
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 16),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextField(
                        controller: reversedController,
                        focusNode: reversedFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(letterSpacing: 10),
                        decoration: InputDecoration(
                          counter: Offstage(),
                          enabledBorder: reversedBorder,
                          focusedBorder: reversedBorder,
                        ),
                        onChanged: (value) {
                          loggerService.debug(
                              'reversedRandomNumber: $reversedRandomNumber');
                          if (value == reversedRandomNumber) {
                            reversedFocusNode.unfocus();
                            reversedInputValid.value = true;
                          } else {
                            reversedInputValid.value = false;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.continueButtonTitle,
          skip: !reversedInputValid.value,
        ));
  }

  String generateRandom() {
    final List<int> list = List.generate(10, (index) {
      return Random().nextInt(10);
    });
    return list.join();
  }
}
