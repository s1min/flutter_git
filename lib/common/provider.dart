import 'package:flutter/material.dart';

// 该方法用于在 Dart 中获取模板类型
Type _typeOf<T>() => T;

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({
    @required this.data,
    Widget child
  }): super(child: child);

  // 共享状态使用泛型
  final T data;

  @override
  // 在此简单返回 `true`，则每次更新都会调用依赖其子孙节点的 `didChangeDependencies`
  bool updateShouldNotify(InheritedProvider<T> old) => true;
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child
  });

  final Widget child;
  final T data;

  // 定义一个便捷方法，方便子树中的 widget 获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
    final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
      ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
      : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化(model 类调用了 `notifyListeners`，重新构建 `InheritedProvider`
    setState(() {

    });
  }

  @override void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当 Provider 更新时，如果新旧数据不 '=='，则解绑旧数据监听，同事添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给 model 添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除 model 的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child
    );
  }
}
