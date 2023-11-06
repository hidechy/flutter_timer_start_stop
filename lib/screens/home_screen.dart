import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import '../state/app_param/app_param_notifier.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  DateTime? _createTime;
  Timer? _timer;
  int count = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    var count = ref.watch(appParamProvider.select((value) => value.count));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('HomeScreen'),
            SizedBox(height: 20),
            Text(count.toString()),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _startTimer();
                  },
                  child: Text('start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _timer?.cancel();
                  },
                  child: Text('stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _startTimer() {
    final createTime = DateTime.now().add(const Duration(seconds: 1));

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _ref.read(appParamProvider.notifier).setCount(value: count++);
    });
  }
}
