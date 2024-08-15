import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomStepper extends ConsumerWidget {
  final StateProvider<int> timerProvider;

  const CustomStepper({super.key, required this.timerProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(timerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$counter',
          style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Kumbh Sans',
              fontWeight: FontWeight.w700),
        ),
        // Adjust space between arrows and text
        const SizedBox(width: 80),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: const Icon(Icons.keyboard_arrow_up, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  ref.read(timerProvider.notifier).state++;
                }),
            IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (counter > 0) {
                    ref.read(timerProvider.notifier).state--;
                  }
                }),
          ],
        ),
      ],
    );
  }
}
