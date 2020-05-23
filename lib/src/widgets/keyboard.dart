import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  Keyboard({this.onChanged, this.textEditingController});

  final ValueSetter<String> onChanged;
  final TextEditingController textEditingController;

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  String _value = "";
  List<String> titles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  _setText(String value) async {
    _value += value;
    widget.textEditingController.text = _value;
    this.widget.onChanged(_value);
    setState(() {});
  }

  List<Widget> _getDialerButtons() {
    var rows = List<Widget>();
    var items = List<Widget>();

    for (var i = 0; i < titles.length; i++) {
      if (i % 3 == 0 && i > 0) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        );
        items = List<Widget>();
      }

      items.add(
        DialButton(
          title: titles[i],
          onTap: _setText,
        ),
      );
    }
    rows.add(
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items),
    );

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ..._getDialerButtons(),
      ],
    );
  }
}

class DialButton extends StatefulWidget {
  final Key key;
  final String title;
  final ValueSetter<String> onTap;

  DialButton({
    this.key,
    this.title,
    this.onTap,
  });

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.090;

    return Material(
      type: MaterialType.circle,
      color: Color(0xFFF7F7FA),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          this.widget.onTap(widget.title);
          setState(() {});
        },
        child: Container(
          height: sizeFactor,
          width: sizeFactor,
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: sizeFactor / 2,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
