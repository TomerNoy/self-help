import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/services/services.dart';

class FlowDrawer extends ConsumerWidget {
  const FlowDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logo = Image.asset(AssetsConstants.selfHelpIcon, width: 70);
    final page = ref.read(routerListenerProvider);
    loggerService.debug('§§ FlowDrawer: page: $page');

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark,
                ],
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: logo,
                ),
                const SizedBox(height: 16),
                Text(
                  'Self Help',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          if (page != RoutePaths.home)
            ListTile(
              title: const Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(routerStateProvider).goNamed(RoutePaths.home.name);
                });
              },
            ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(routerStateProvider).goNamed(RoutePaths.profile.name);
              });
            },
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(routerStateProvider).goNamed(RoutePaths.settings.name);
              });
            },
          ),
        ],
      ),
    );
  }
}
