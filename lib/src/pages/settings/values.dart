import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';
import 'package:tracker/src/widgets/keyboard.dart';

class TrackerValues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.caption.copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
    return Consumer<Cardinal>(
      builder: (context, cardinal, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 8.0),
              child: Text(
                'Slider values'.toUpperCase(),
                style: textStyle.copyWith(fontSize: 10.0),
              ),
            ),
            ListTile(
              title: Text(
                'Max',
                style: textStyle,
              ),
              trailing: Text(
                '${cardinal.max.round()}',
                style: textStyle,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return KeyboardModal(
                      value: cardinal.max,
                      onChanged: cardinal.updateMax,
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Min', style: textStyle),
              trailing: Text(
                '${cardinal.min.round()}',
                style: textStyle,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return KeyboardModal(
                      value: cardinal.min,
                      onChanged: cardinal.updateMin,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class KeyboardModal extends StatefulWidget {
  KeyboardModal({this.onChanged, this.value});

  final Function onChanged;
  final double value;

  @override
  _KeyboardModalState createState() => _KeyboardModalState();
}

class _KeyboardModalState extends State<KeyboardModal> {
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(
      text: '${widget.value.round()}',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var screenHeight = screen.height * 0.085;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: kToolbarHeight * 1.2,
          child: TextField(
            decoration: InputDecoration.collapsed(hintText: ''),
            textAlign: TextAlign.center,
            controller: textEditingController,
            style: TextStyle(
              fontSize: screenHeight / 2,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Keyboard(
            textEditingController: textEditingController,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
