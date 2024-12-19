import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/widgets/flow_appbar.dart';
import 'package:self_help/core/widgets/flow_navigation_bar.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/routes/router.dart';

class EnterNumber extends HookConsumerWidget {
  const EnterNumber({
    super.key,
  });

  static const listLength = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final isValid = useState(false);

    final title = localizations.enterNumber;
    final subtitles = localizations.enterNumberSubtitle;

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
                    if (value.length == 10) {
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
        onPressed: isValid.value
            ? () => context.pushNamed(
                  AppRoutes.enterNumberReversed,
                  pathParameters: {'userNumber': controller.text},
                )
            : null,
      ),
    );
  }
}
