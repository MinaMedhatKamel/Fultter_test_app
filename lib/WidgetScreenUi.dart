import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class WidgetScreenUi extends StatelessWidget {
  WidgetScreenUi({this.title,this.context});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: _handleClickActionBar,
          ),
        ],
      ),
    );
  }
  void _handleClickActionBar(){
    Toast.show("clicked", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}



class WidgetScreenUiScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: body(context));
    // Column is a vertical, linear layout.
  }

  Widget body(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetScreenUi(
          title: Text(
            'Example title',
            style: Theme.of(context).primaryTextTheme.title,
          ),
          context: context,
        ),
        Expanded(
          child: Center(
            child: Text('Hello, world!'),
          ),
        ),
        GestureDetector(
          onTap: () {
            print('MyButton was tapped!');
          },
          onDoubleTap: () {
            print('MyButton was onDoubleTap!');
          },
          child: Container(
            height: 36.0,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.lightGreen[500],
            ),
            child: Center(
              child: Text('Engage'),
            ),
          ),
        )
      ],
    );
  }
}
