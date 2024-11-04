import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_help/core/widgets/page_navigator.dart';
import 'package:self_help/pages/widgets/page_app_bar.dart';
import 'package:self_help/providers/page_route_provider.dart';

class Butterfly extends ConsumerWidget {
  const Butterfly({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowController = ref.read(pageRouteProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          flowController.backNoPop();
        }
      },
      child: Scaffold(
        appBar: PageAppBar(title: 'Butterfly'),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(text: 'Butterfly'),
                                Tab(text: 'Hands on Chest'),
                              ],
                            ),
                            SizedBox(
                              height: 400,
                              child: TabBarView(
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text('instructions'),
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                              child: Text('Butterfly image')),
                                        )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text('instructions'),
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                              child:
                                                  Text('Hands on Chest image')),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text('Start Timer 00:00'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StepNavigator(),
            ],
          ),
        ),
      ),
    );
  }
}

// tab with 2 options
// one is the butterfly
// second is the timer hands on chest, 30s with restart
// same layouts with content in the protocol
