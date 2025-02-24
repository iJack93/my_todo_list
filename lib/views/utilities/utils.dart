import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//MediaQuery Extensions on BuildContext
extension MediaQueryExtensions on BuildContext {
  /// Get the [BuildContext] size object
  Size get size => MediaQuery.sizeOf(this);

  /// Get the [BuildContext] padding object
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Get the [BuildContext] width
  double get width => size.width;

  /// Get the [BuildContext] height
  double get height => size.height;

  /// Get the [BuildContext] top padding
  double get topPadding => padding.top;

  /// Get the [BuildContext] bottom padding
  double get bottomPadding => padding.bottom;

  /// Get the [Theme] instance
  ThemeData get theme => Theme.of(this);

  /// Get the [ThextTheme] instance for the actual [Theme]
  TextTheme get textTheme => theme.textTheme;

}
