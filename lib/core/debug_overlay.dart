import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/pages/global_providers/collapsing_appbar_provider.dart';
import 'package:self_help/pages/global_providers/page_route_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';
import 'package:invert_colors/invert_colors.dart';

class DebugOverlay extends HookConsumerWidget {
  const DebugOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugOn = useState<bool>(true);

    final authProvider = ref.watch(userAuthProvider);
    final route = ref.watch(routerListenerProvider);
    final appBarType = ref.watch(collapsingAppBarProvider);
    final pageFlow = ref.watch(pageFlowProvider);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          if (debugOn.value)
            Column(
              children: [
                Spacer(),
                Material(
                  color: Colors.black.withAlpha(100),
                  child: InvertColors(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text('auth: '),
                              Text('${authProvider.value?.name}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('route: '),
                              Text(route.name),
                            ],
                          ),
                          Row(
                            children: [
                              Text('flow route: '),
                              Text('${pageFlow.flowType}, ${pageFlow.index}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('animated appBar: '),
                              Text(appBarType.name),
                            ],
                          ),
                          Divider(),
                          Wrap(
                            children: List.generate(
                              AppBarType.values.length,
                              (index) {
                                return OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    ref
                                        .watch(
                                            collapsingAppBarProvider.notifier)
                                        .updateState(AppBarType.values[index]);
                                  },
                                  child: Text(
                                    AppBarType.values[index].name.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          SafeArea(
            child: Material(
              shape: const CircleBorder(),
              color: Colors.black.withAlpha(100),
              child: IconButton(
                onPressed: () {
                  print('debugOn.value: ${debugOn.value}');
                  debugOn.value = !debugOn.value;
                },
                color: Colors.white,
                icon: Icon(
                  debugOn.value ? Icons.build : Icons.highlight_off,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
