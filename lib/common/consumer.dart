import 'package:flutter/material.dart';
import 'package:flutter_git/common/provider.dart';

class Consumer<T> extends StatelessWidget {
  Consumer({
    Key key,
    @required this.builder,
    this.child
  }): assert(builder != null), super(key: key);

  final Widget Function(BuildContext context, T value) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context)  // 自动获取 Model
    );
  }
}
