import 'dart:async';
import './class_api.dart';
import 'class_dp.dart';
import '../models/item_model.dart';

class RepositoryProvider {
  // NewsApiProvider apiProvider = NewsApiProvider();
  // NewsDbProvider dbProvider = NewsDbProvider();

  List<Source> sources = [
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    Source source;

    for (source in sources) {
      item = await source.fetchItems(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItems(item!);
    }
    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clearTable();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItems(int id);
}

abstract class Cache {
  Future<int> addItems(ItemModel item);
  Future<int> clearTable();
}
