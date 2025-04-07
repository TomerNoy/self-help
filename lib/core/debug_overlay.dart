import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:self_help/pages/global_providers/page_flow_provider.dart';
import 'package:self_help/pages/global_providers/router_provider.dart';
import 'package:self_help/pages/global_providers/user_auth_provider.dart';

class DebugOverlay extends HookConsumerWidget {
  const DebugOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugOn = useState<bool>(true);

    final authProvider = ref.watch(userAuthProvider);
    final route = ref.watch(routerListenerProvider);
    final pageFlow = ref.watch(pageFlowProvider);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          if (debugOn.value)
            SizedBox.expand(
              child: Column(
                children: [
                  Spacer(),
                  Material(
                    color: Colors.black.withAlpha(100),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Row(
                          //   children: [
                          //     Text('auth: '),
                          //     Text('${authProvider.value?.name}'),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Text('route: '),
                          //     Text(route.name),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Text('flow route: '),
                              Text(
                                  '${pageFlow.flowList.length}, ${pageFlow.index},'),
                            ],
                          ),
                          // Divider(),
                          // Wrap(
                          //   alignment: WrapAlignment.center,
                          //   crossAxisAlignment: WrapCrossAlignment.center,
                          //   runSpacing: 4,
                          //   spacing: 8,
                          //   children: List.generate(
                          //     AppOverlayType.values.length,
                          //     (index) {
                          //       return InkWell(
                          //         onTap: () {
                          //           ref
                          //               .read(appOverlayProvider.notifier)
                          //               .updateState(
                          //                 AppOverlayState(
                          //                   type: AppOverlayType.values[index],
                          //                 ),
                          //               );
                          //         },
                          //         child: Container(
                          //           color: Colors.white.withAlpha(100),
                          //           child: Text(
                          //             AppOverlayType.values[index].name,
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                          // Divider(),
                          // Wrap(
                          //   alignment: WrapAlignment.center,
                          //   crossAxisAlignment: WrapCrossAlignment.center,
                          //   runSpacing: 4,
                          //   spacing: 8,
                          //   runAlignment: WrapAlignment.center,
                          //   children: List.generate(
                          //     RoutePaths.values.length,
                          //     (index) {
                          //       final route = RoutePaths.values[index];
                          //       return InkWell(
                          //         onTap: () {
                          //           ref.read(routerStateProvider).pushNamed(
                          //                 route.name,
                          //               );
                          //         },
                          //         child: Container(
                          //           color: Colors.black.withAlpha(100),
                          //           child: Text(
                          //             route.name,
                          //             style: TextStyle(color: Colors.white),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            right: 100,
            top: 0,
            child: SafeArea(
              child: Material(
                shape: const CircleBorder(),
                color: Colors.black.withAlpha(50),
                child: IconButton(
                  onPressed: () => debugOn.value = !debugOn.value,
                  color: Colors.white,
                  icon: Icon(
                    debugOn.value ? Icons.build : Icons.highlight_off,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
