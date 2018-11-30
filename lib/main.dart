import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hover Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: new BoxConstraints.tight(Size(300.0, 400.0)),
          child: Container(
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Tap to focus.'),
                TestFocusable(),
                TestFocusable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TestFocusable extends StatefulWidget {
  const TestFocusable({
    Key key,
    this.notFocusedLabel = 'Not Focused',
    this.focusedLabel = 'Focused',
    this.autofocus = true,
  }) : super(key: key);

  final String notFocusedLabel;
  final String focusedLabel;
  final bool autofocus;

  @override
  TestFocusableState createState() => TestFocusableState();
}

class TestFocusableState extends State<TestFocusable> {
  final FocusNode focusNode = FocusNode();
  bool _didAutofocus = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didAutofocus && widget.autofocus) {
      _didAutofocus = true;
      FocusScope.of(context).autofocus(focusNode);
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: AnimatedBuilder(
        animation: focusNode,
        builder: (BuildContext context, Widget child) {
          return Container(
            color: focusNode.hasFocus ? Colors.red : Colors.blueGrey,
            margin: EdgeInsets.all(10),
            width: 100.0,
            height: 100.0,
            child: Text(focusNode.hasFocus ? widget.focusedLabel : widget.notFocusedLabel,
                textDirection: TextDirection.ltr),
          );
        },
      ),
    );
  }
}
