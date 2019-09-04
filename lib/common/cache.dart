import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter_git/common/global.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;
  Response response;
  int timeStamp;

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // 为了确保迭代器顺序和对象插入时间一致顺序一致，使用 LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options) {
    if (!Global.profile.cache.enable) return options;

    // refresh 标记是否是下拉刷新
    bool refresh = options.extra['refresh'] == true;

    // 如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra['list'] == true) {
        // 若是列表，则只要 url 中包含当前 path 的缓存全部删除
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只是删除 uri 相同的缓存
        delete(options.uri.toString());
      }
      return options;
    }

    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];

      if (ob != null) {
        // 若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          // 若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
  }

  @override
  onError(DioError err) {
    // 错误状态不缓存
  }

  @override
  onResponse(Response response) {
    // 如果启用缓存，将返回结果保存到缓存
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response object) {
    RequestOptions options = object.request;

    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      // 如果缓存数量超过最大数量限制，则先移出最早的一条记录
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
