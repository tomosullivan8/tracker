import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';
import 'package:tracker/provider/conductor.dart';
import 'package:tracker/src/bottom_sheet/buttons.dart';
import 'package:tracker/src/bottom_sheet/date_time.dart';
import 'package:tracker/src/bottom_sheet/slider.dart';
import 'package:tracker/src/theme.dart';

class DraggableSheet extends StatefulWidget {
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
    final _conductor = context.watch<Conductor>();
    final _value = context.watch<Conductor>().value;

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        double extent = notification.extent;
        context.read<Conductor>().changeOffset(extent);
        return;
      },
      child: DraggableScrollableActuator(
        child: DraggableScrollableSheet(
          maxChildSize: _conductor.maxHeight,
          initialChildSize: _conductor.minHeight,
          minChildSize: _conductor.minHeight,
          builder: (context, scrollController) {
            return Material(
              color: Color.lerp(Colors.white, Color(0xFFF7F7FA), _value),
              elevation: 8.0 + (8.0 * _value),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: screen.size.height * _conductor.maxHeight,
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        _buildMiniView(),
                        _buildMainView(),
                        _buildTitleView(),
                        _expandIcon(),
                      ],
                    ),
                    _buildComponents(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _expandIcon() {
    final _value = context.read<Conductor>().value;
    return Opacity(
      opacity: math.pow(1 - _value, 6),
      child: Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: Icon(
          Icons.maximize,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildTitleView() {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
    final _title = context.read<Cardinal>().title;
    final _value = context.read<Conductor>().value;
    return Opacity(
      opacity: math.pow(_value, 6),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: screen.padding.top),
        height: kToolbarHeight + screen.padding.top,
        child: Text(_title, style: theme.textTheme.headline6),
      ),
    );
  }

  Widget _buildMainView() {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
    final _value = context.read<Conductor>().value;
    double minimize(value) => (value * _value);
    double sizedBox() {
      final minHeight = kToolbarHeight - 16.0;
      final edgeInsets = kToolbarHeight * 2.5;
      return (minHeight + (minimize(screen.size.width - edgeInsets)));
    }

    double size = sizedBox();
    return Align(
      alignment: Alignment.lerp(
        Alignment.centerLeft,
        Alignment.center,
        _value,
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: 8.0 + minimize(kToolbarHeight + 16.0),
          left: 16.0 * (1 - _value),
        ),
        height: size,
        width: size,
        child: Material(
          borderRadius: BorderRadius.circular(4.0),
          clipBehavior: Clip.antiAlias,
          color: Color.lerp(
            Color(0xFFF7F7FA),
            Colors.grey[300],
            _value,
          ),
          child: Consumer<Cardinal>(
            builder: (_, cardinal, __) {
              bool hasImage = cardinal.image.existsSync();
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: hasImage
                      ? DecorationImage(
                          image: FileImage(cardinal.image),
                          colorFilter: ColorFilter.mode(
                            Colors.black38,
                            BlendMode.darken,
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '${cardinal.value.round()}',
                    style: theme.textTheme.headline6.copyWith(
                      color: hasImage
                          ? Colors.white
                          : Color.lerp(
                              primaryVariant,
                              Colors.white,
                              _value * 2,
                            ),
                      fontSize: 16.0 + minimize(40.0),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMiniView() {
    final _value = context.read<Conductor>().value;
    return Opacity(
      opacity: 1.0 - (_value * 3).clamp(0.0, 1.0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: kToolbarHeight,
            padding: EdgeInsets.only(left: 16.0 + kToolbarHeight),
            child: DateTimeText(
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponents() {
    return Consumer<Conductor>(
      builder: (context, conductor, child) {
        return Opacity(
          opacity: math.pow(conductor.value, 3),
          child: Container(
            height: kToolbarHeight * 4,
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0 + (kToolbarHeight * 2 * (1.0 - conductor.value)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: DateTimeText(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SheetSlider(),
                ActionButtons(),
              ],
            ),
          ),
        );
      },
    );
  }
}
