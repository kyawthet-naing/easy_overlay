## Easy Overlay

The Easy Overlay package makes it simple to add visual feedback to your Flutter app, enhancing user experience. It offers flexible options for displaying customizable overlays and toast notifications, whether you prefer using context or not. Whether you need a CircularProgressIndicator, a custom widget, or flexible toast messages, this package provides a highly customizable solution for managing loading states and interactions.

- [Installation](#installation)
- [With Context](#with-context)
- [Without Context](#without-context)
- [Customizable UI](#customizable-ui)
- [Toast Message With Context](#toast-message-with-context)
- [Toast Message Without Context](#toast-message-without-context)

## Installation

To use Easy Overlay, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  easy_overlay: ^latest
```

Then, import the package in your Dart code:

```dart
import 'package:easy_overlay/easy_overlay.dart';
```

## With Context

No extra configuration is needed to use the Easy Overlay package with context.

**Example**

```dart
void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     home: MyHomePage(),
   );
 }
}

class MyHomePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Easy Overlay Example')),
     body: Center(
       child: ElevatedButton(
         onPressed: () {
           EasyOverlayCtx.show(context);
         },
         child: Text('Show Overlay'),
       ),
     ),
   );
 }
}
```

**Uses**

- Show Overlay: `EasyOverlayCtx.show(context);`
- Dismiss Overlay: `EasyOverlayCtx.dismiss();`

## Without Context

To use the Easy Overlay package without context, initialize EasyOverlay at the builder function of your MaterialApp or CupertinoApp.

**Example**

```dart
void main() {
  runApp(
    MaterialApp(
      builder: EasyOverlay.init(),
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Easy Overlay Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            EasyOverlay.show();
          },
          child: Text('Show Overlay'),
        ),
      ),
    );
  }
}
```

**Uses**

- Show Overlay: `EasyOverlay.show();`
- Dismiss Overlay: `EasyOverlay.dismiss();`

## Customizable UI

You can customize the overlay by passing a custom widget and configuring various options.

**Custom Widget**

- Display a custom widget by specifying it in the `EasyOverlay.show()` method.
- By default, a `CircularProgressIndicator` is shown if no custom widget is provided.

```dart
EasyOverlay.show(
  child: YourCustomWidget(),
);
```

**Customization Options**

- barrierColor: Specify any color to customize the overlay’s background color.
- barrierDismissible: Set to true or false to control whether tapping outside the overlay dismisses it.

**Example**

```dart
EasyOverlay.show(
  //your custom widget
  child: Text(
    'Loading...',
    style: TextStyle(color: Colors.white, fontSize: 24),
  ),
  barrierDismissible: false,
  barrierColor: Colors.black38,
);
```

## Toast Message With Context

**Example**

```dart
 EasyOverlayCtx.showToast(
        context,
        message: "Default Toast With Context",
        alignment: Alignment.bottomCenter,
        decoration: ToastDecoration.origin.copyWith(
        backgroundColor: Colors.cyan,
        ),
    );
```

## Toast Message Without Context

**Example**

```dart
   EasyOverlay.showToast(
        child: const CustomUI(),
        alignment: Alignment.topRight,
        duration: const Duration(milliseconds: 1500),
        animationType: AnimationType.scaleFade,
        animationDuration: const Duration(milliseconds: 400),
  );
```

## Credits

This package is created and maintained by [Kyaw Thet Naing](https://github.com/kyawthet-naing).
