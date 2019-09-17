import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PullLoad extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder; // item 渲染
  final RefreshCallback onLoadMore; // 加载更多回调
  final RefreshCallback onRefresh; // 下拉刷新回调
  final PullLoadControl control; // 控制器，控制一些数据和一些配置
  final Key refreshKey;

  PullLoad(this.control, this.itemBuilder, this.onRefresh, this.onLoadMore,
      {this.refreshKey});

  @override
  _PullLoadState createState() => _PullLoadState(
      this.control,
      this.itemBuilder,
      this.onRefresh,
      this.onLoadMore,
        this.refreshKey,
      );
}

class _PullLoadState extends State<PullLoad> {
  final IndexedWidgetBuilder itemBuilder; // item 渲染
  final RefreshCallback onLoadMore; // 加载更多回调
  final RefreshCallback onRefresh; // 下拉刷新回调
  final PullLoadControl control; // 控制器，控制一些数据和一些配置
  final Key refreshKey;

  _PullLoadState(
    this.control,
    this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.refreshKey,
  );

  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    this.control.needLoadMore?.addListener(() {
      try {
        // 延迟 2s 等待确认
        Future.delayed(Duration(seconds: 2), () {
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          _scrollController.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });

    // 增加滑动监听
    _scrollController.addListener(() {
      // 判断当前滑动位置是否到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (this.control.needLoadMore.value) {
          this.onLoadMore?.call();
        }
      }
    });

    super.initState();
  }

  // 根据配置状态返回实际列表数量
  _getListCount() {
    // 是否需要头部
    if (control.needHeader) {
      // 如果需要头部，用 item 0 的 Widget 作为 ListView 的头部
      // 列表数量大于 0 时，因为头部和底部加载更多选项，需要对列表数据总数 +2
      return (control.dataList.length > 0)
          ? control.dataList.length + 2
          : control.dataList.length + 1;
    } else {
      // 如果不需要头部，在没有数据时，固定返回数量 1 用于空页面呈现
      if (control.dataList.length == 0) {
        return 1;
      }

      // 如果有数据，因为不加载更多选项，需要对列表数据总数 +1
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length;
    }
  }

  // 根据配置状态返回实际列表渲染 item
  _getItem(int index) {
    if (!control.needHeader &&
        index == control.dataList.length &&
        control.dataList.length != 0) {
      // 如果不需要头部，并且数据不为 0，当 index 等于数据长度时，
      // 渲染加载更多 item（因为 index 是从0开始）
      return _buildProgressIndicator();

    } else if (control.needHeader &&
        index == _getListCount() - 1 &&
        control.dataList.length != 0) {
      // 如果需要头部，并且数据不为 0，当 index 等于实际渲染长度 -1 时，渲染加载更多 item
      return _buildProgressIndicator();

    } else if (!control.needHeader && control.dataList.length == 0) {
      // 如果不需要头部，并且数据为 0，渲染空页面
      return _buildEmpty();

    } else {
      // 回调外部正常渲染 item，如果这里有需要，可以直接返回相对位置的 index
      return itemBuilder(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey, // GlobalKey，用户外部获取 RefreshIndicator 的 State，做显示刷新
      onRefresh: onRefresh, // 下拉刷新，返回的是一个 Future
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(), // 保持 ListView 任何情况都能滚动
        itemBuilder: (context, index) => _getItem(index),  // 根据状态返回子键
        itemCount: _getListCount(),  // 根据状态返回数量
        controller: _scrollController,  // 滑动监听
      ),
    );
  }

  // 空页面
  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(''),
          ),
          Container(
            child: Text(''),
          ),
        ],
      ),
    );
  }

  // 上拉加载更多
  Widget _buildProgressIndicator() {
    // 是否需要显示上拉加载更多的 loading
    Widget bottomWidget = (control.needLoadMore.value)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // loading 框
              SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
              Container(
                width: 5,
              ),
              Text('正在加载'),
            ],
          )
        : Container();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }
}

class PullLoadControl {
  // 数据，对齐增减，不能替换
  List dataList = new List();

  // 是否需要加载更多
  ValueNotifier<bool> needLoadMore = new ValueNotifier(false);

  // 是否需要头部
  bool needHeader = true;
}
