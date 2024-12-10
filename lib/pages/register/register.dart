import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/register/widgets/register_form.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final logo = SvgPicture.asset(
      'assets/icons/logo.svg',
      height: 70,
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final collapsedPanelHeight = screenHeight * 0.39 - statusBarHeight;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: collapsedPanelHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                  child: AnimatedMeshGradient(
                    colors: const [
                      Color(0xFFEDDBC5),
                      Color(0xFFEDBFF3),
                      Color(0xFFE7BBCD),
                      Color(0xFFEFDDFD),
                    ],
                    options: AnimatedMeshGradientOptions(
                      speed: 2,
                      amplitude: 5,
                      frequency: 4,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  logo,
                  Text(
                    localizations.registeration,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              )
            ],
          ),

          // Register form
          RegisterForm(),
        ],
      ),
    );
  }
}
