# Easy Overlay

It simplifies the process of adding visual feedback for ongoing tasks or data retrieval, enhancing user experience. With customizable options for different types of overlays and easy integration, you can efficiently manage loading states and ensure smooth interaction in your application. Whether you need a default CircularProgressIndicator or a custom widget, this package provides a flexible solution for various situations, such as:

- **Fetching Data**: Display a loading overlay while retrieving data from an API or database.
- **Executing Background Tasks**: Show an overlay during background operations like file processing or uploads.
- **State Transitions**: Indicate transitions between screens or states with a loading overlay.
- **User Actions**: Provide feedback during user-initiated actions, such as form submissions or searches.

## Getting Started

The Easy Overlay package offers flexible options for displaying overlays in your Flutter application, whether you prefer using context or not, and allows for a highly customizable UI.

- [Installation](#installation)
- [With Context](#with-context)
- [Without Context](#without-context)
- [Customizable UI](#customizable-ui)

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

- Display a custom widget by specifying it in the ```EasyOverlay.show()``` method.
- By default, a ```CircularProgressIndicator``` is shown if no custom widget is provided.

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

## Credits

This package is created and maintained by [Kyaw Thet Naing](https://github.com/kyawthet-naing).
