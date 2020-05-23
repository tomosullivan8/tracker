import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/item.dart';

/// [Cardinal] is the main [Provider] used throughout the application
/// for State Management.

class Cardinal extends ChangeNotifier {
  /// Call upon Cardinal upon initiation.
  Cardinal() {
    _load();
    _loadTitle();
    _loadImage();
    _loadMinMax();
  }

  bool loading = true;

  List<Items> _items = [];

  List<Items> get items => List.from(_items);

  Future<String> get _path async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _file async {
    final path = await _path;
    return File('$path/file.txt');
  }

  Future<File> _save(List<Items> items) async {
    final file = await _file;

    final String json = JsonEncoder().convert({
      'items': items.map((i) => i.toJson()).toList(),
    });

    return file.writeAsString(json);
  }

  Future<List<Items>> _read() async {
    List<Items> items;
    try {
      final file = await _file;

      /// Read the contents of the file and convert from json to items;
      String contents = await file.readAsString();
      final json = JsonDecoder().convert(contents);
      items = json['items'].map<Items>((i) => Items.fromJson(i)).toList();

      return items;
    } catch (e) {
      print(e);

      /// Return an empty list if there is an exception.
      return [];
    }
  }

  void _load() {
    _read().then((value) {
      print(value);
      _items = value;
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

  void addItem() {
    final item = Item(item: _value.toInt());
    final DateTime now = DateTime.now();
    final DateTime dateTime = DateTime(now.year, now.month, 21);
    int index = _items.indexWhere((i) => i.date == dateTime);
    if (index != -1) {
      _items[index].items.add(item);
    } else {
      _items.add(
        Items(
          date: dateTime,
          items: [item],
        ),
      );
    }
    _save(_items);
    print(_items);
    notifyListeners();
  }

  Future<File> clear() async {
    final file = await _file;
    _items.clear();
    notifyListeners();
    return file.delete();
  }

  /// Provide a title for the tracker to give an identity.

  String _title = '';

  String get title => _title;

  TextEditingController textEditingController;

  void _loadTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _title = prefs.getString('title') ?? '';
    textEditingController = TextEditingController(text: _title);
    notifyListeners();
  }

  void changeTitle(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _title = value;
    prefs.setString('title', _title);
    notifyListeners();
  }

  /// The image to be used in the foreground for the [DraggableScrollableSheet].
  /// Make sure not null on init or will throw error.

  File _image = File('image.png');

  File get image => _image;

  void pickImage() async {
    File getImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    String path = await _path;

    if (getImage != null) {
      File localImage = await getImage.copy('$path/image.png');
      _image = localImage;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<File> _readImage() async {
    try {
      String path = await _path;
      return File('$path/image.png');
    } catch (e) {
      return e;
    }
  }

  _loadImage() {
    _readImage().then((value) {
      _image = value;
    }).whenComplete(() {
      notifyListeners();
    }).catchError((e) {
      _image = null;
      notifyListeners();
    });
  }

  /// The value to be used for the [Items].

  double _value = 0.0;

  double get value => _value;

  void increaseIncrement() {
    _value = _value + 1.0;
    notifyListeners();
  }

  void decreaseIncrement() {
    _value = _value - 1.0;
    notifyListeners();
  }

  void changeValue(value) {
    _value = value;
    notifyListeners();
  }

  double _min = 0.0;

  double get min => _min;

  double _max = 100.0;

  double get max => _max;

  void _loadMinMax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _min = prefs.getDouble('min') ?? 0.0;
    _max = prefs.getDouble('max') ?? 100.0;
    notifyListeners();
  }

  void updateMin(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _min = double.parse(value);
    prefs.setDouble('min', _min);
    notifyListeners();
  }

  void updateMax(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _max = double.parse(value);
    prefs.setDouble('max', _max);
    notifyListeners();
  }
}
