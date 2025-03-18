import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/constants/assets_constants.dart';
import 'package:self_help/core/constants/routes_constants.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';

class FlowDrawer extends ConsumerWidget {
  const FlowDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logo = Image.asset(AssetsConstants.selfHelpIcon, width: 70);
    final page = ref.read(routerListenerProvider);

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
                final provider = ref.read(routerStateProvider);
                provider.goNamed(RoutePaths.home.name);
                Navigator.of(context).pop();
              },
            ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              final provider = ref.read(routerStateProvider);
              // while (provider.canPop() == true) {
              //   provider.pop();
              // }
              provider.pushNamed(RoutePaths.profile.name);
              Navigator.of(context).pop();
            },
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: const Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              final provider = ref.read(routerStateProvider);
              // while (provider.canPop() == true) {
              //   provider.pop();
              // }
              provider.pushNamed(RoutePaths.settings.name);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
