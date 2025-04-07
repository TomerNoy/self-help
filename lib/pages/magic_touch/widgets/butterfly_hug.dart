import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_hooks/use_appbar_manager.dart';
import 'package:self_help/pages/global_widgets/flow_navigation_bar.dart';
import 'package:self_help/services/services.dart';

class ButterflyHug extends HookConsumerWidget {
  const ButterflyHug({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggerService.debug('ButterflyHug widget built');

    final localizations = AppLocalizations.of(context)!;
    final title = 'חיבוק עצמי'; //TODO: use localization
    final subtitle = localizations.butterflyHug;

    useAppBarManager(
      ref: ref,
      title: title,
      subtitle: subtitle,
      routePath: RoutePaths.butterflyHug,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsConstants.butterflyGirl,
                height: 200,
              ),
              const SizedBox(height: 20),
              Text(
                'starting butterfly hug',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FlowNavigationBar(
        title: localizations.continueButtonTitle,
        // skip: !reversedInputValid.value,
      ),
    );
  }
}
