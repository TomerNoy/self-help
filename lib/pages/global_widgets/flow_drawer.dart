import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/routes_constants.dart';
// import 'package:self_help/l10n/generated/app_localizations.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class FlowDrawer extends ConsumerWidget {
  const FlowDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final localization = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Self Help',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              final provider = ref.read(routerStateProvider);
              provider.goNamed(RoutePaths.home.name);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              final provider = ref.read(routerStateProvider);
              while (provider.canPop() == true) {
                provider.pop();
              }
              provider.pushNamed(RoutePaths.profile.name);
            },
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              final provider = ref.read(routerStateProvider);
              while (provider.canPop() == true) {
                provider.pop();
              }
              provider.pushNamed(RoutePaths.settings.name);
            },
          ),
        ],
      ),
    );
  }
}
