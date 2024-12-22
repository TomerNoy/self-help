import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/pages/global_widgets/flow_appbar.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';

class EnterNumberReversed extends HookConsumerWidget {
  const EnterNumberReversed({
    super.key,
    required this.userNumber,
  });

  final String userNumber;

  static const listLength = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final userNumberReversed = userNumber.split('').reversed.join();

    final isValid = useState(false);

    final title = localizations.enterNumberBackwards;
    final subtitles = localizations.enterNumberBackwardsSubtitle;

    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });
      return null;
    }, []);

    return Scaffold(
        appBar: FlowAppBar(
          title: title,
          subtitle: subtitles,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
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
                    ),
                    onChanged: (value) {
                      if (userNumberReversed == value) {
                        focusNode.unfocus();
                        isValid.value = true;
                      } else {
                        isValid.value = false;
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: FlowNavigationBar(
          title: localizations.continueButtonTitle,
        ));
  }
}
