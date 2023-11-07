import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/app_param/app_param_notifier.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  Timer? _timer;
  int count = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    var stateCount = ref.watch(appParamProvider.select((value) => value.count));

    if (stateCount >= 20) {
      _timer?.cancel();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('HomeScreen'),
            const SizedBox(height: 20),
            Text(stateCount.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _startTimer(),
              child: const Text('start'),
            ),
            ElevatedButton(
              onPressed: () => _timer?.cancel(),
              child: const Text('stop'),
            ),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                _timer = Timer(
                  const Duration(milliseconds: 1500),
                  () {
                    count = 0;

                    _ref.read(appParamProvider.notifier).setCount(value: 0);
                  },
                );
              },
              child: const Text('reset'),
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _startTimer() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 1500),
        (timer) =>
            _ref.read(appParamProvider.notifier).setCount(value: count++));
  }
}
