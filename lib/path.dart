import 'package:flutter/cupertino.dart';

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, RouteSettings) builder;
}
