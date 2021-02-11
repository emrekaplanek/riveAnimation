import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool left = true;
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  Color _color;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/dayswitch.riv').then(
      (data) async {
        final file = RiveFile();
        if (file.import(data)) {
          final artboard = file.mainArtboard;
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Rive(artboard: _riveArtboard),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        child: Icon(
          Icons.play_arrow,
        ),
      ),
    );
  }

  void _togglePlay() {
    setState(() {
      if (left) {
        _riveArtboard.addController(_controller = SimpleAnimation('toRight'));
        _color = Colors.blueGrey;
        left = false;
      } else {
        _riveArtboard.addController(_controller = SimpleAnimation('toLeft'));
        _color = Colors.amber;
        left = true;
      }
    });
  }
}
