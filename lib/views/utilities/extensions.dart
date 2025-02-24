import 'package:flutter/material.dart';

//value notifier for lists
class PropertyValueNotifier<T> extends ValueNotifier<T> {
  PropertyValueNotifier(T value) : super(value);

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}