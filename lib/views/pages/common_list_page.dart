import 'package:flutter/material.dart';
import 'package:flutter_git/views/widgets/list_state.dart';
import 'package:flutter_git/views/widgets/pull/pull_load.dart';

class CommonListPage extends StatefulWidget {
  final String userName;
  final String reposName;
  final String showType;
  final String dataType;
  final String title;

  CommonListPage(this.title, this.showType, this.dataType,
      {this.userName, this.reposName});

  @override
  _CommonListPageState createState() => _CommonListPageState();
}

class _CommonListPageState extends State<CommonListPage>
    with
        AutomaticKeepAliveClientMixin<CommonListPage>,
        ListState<CommonListPage> {
  _CommonListPageState();

  _renderItem(index) {
    if (pullLoadControl.dataList.length == 0) {
      return null;
    }
    var data = pullLoadControl.dataList[index];
  }

  _getDataLogic() async {

  }

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    return await _getDataLogic();
  }

  @override
  requestLoadMore() async {
    return await _getDataLogic();
  }

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PullLoad(
        pullLoadControl,
        (BuildContext context, int index) => _renderItem(index),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
