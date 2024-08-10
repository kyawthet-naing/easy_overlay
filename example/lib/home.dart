import 'package:easy_overlay/easy_overlay.dart';
import 'package:example/custom_ui.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Overlay'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: _overlayDefault,
              child: const Text('Overlay With Default UI'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _overlayWithCustomUI,
              child: const Text('Overlay With Custom UI'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                EasyOverlayCtx.showToast(
                  context,
                  message: "Default Toast With Context",
                  alignment: Alignment.bottomCenter,
                  decoration: ToastDecoration.origin.copyWith(
                    backgroundColor: Colors.cyan,
                  ),
                );
              },
              child: const Text('Default Toast With Context'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                EasyOverlayCtx.showToast(
                  context,
                  child: const CustomUI(),
                  alignment: Alignment.bottomRight,
                  duration: const Duration(milliseconds: 1500),
                  animationType: AnimationType.scaleFade,
                  animationDuration: const Duration(milliseconds: 400),
                );
              },
              child: const Text('Custom Toast With Context'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                EasyOverlay.showToast(
                  message: "Default Toast Without Context",
                  animationType: AnimationType.slideRight,
                  alignment: Alignment.topLeft,
                );
              },
              child: const Text('Default Toast Without Context'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                EasyOverlay.showToast(
                  child: const CustomUI(),
                  alignment: Alignment.topRight,
                  duration: const Duration(milliseconds: 1500),
                  animationType: AnimationType.scaleFade,
                  animationDuration: const Duration(milliseconds: 400),
                );
              },
              child: const Text('Custom Toast Without Context'),
            ),
          ],
        ),
      ),
    );
  }

  _overlayDefault() async {
    EasyOverlay.show();
    await Future.delayed(const Duration(seconds: 2));
    EasyOverlay.dismiss();
  }

  _overlayWithCustomUI() async {
    EasyOverlay.show(child: const CustomUI());
    await Future.delayed(const Duration(seconds: 2));
    EasyOverlay.dismiss();
  }
}
