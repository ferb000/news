import 'package:rxdart/rxdart.dart';
import '../resources/repository_provider.dart';
import '../models/item_model.dart';

class TopstoriesBloc {
  TopstoriesBloc() {
    fetchTopIds();
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }
  final _respository = RepositoryProvider();

  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  // exposing the stream to the application
  Stream<List<int>> get fetchTodIds {
    return _topIds.stream;
  }

  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

// exposinng sinks to the application
  Function(int) get fetchItems {
    return _itemsFetcher.sink.add;
  }

  fetchTopIds() async {
    final ids = await _respository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() async {
    await _respository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, _) {
        print(_);
        cache[id] = _respository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }
}

TopstoriesBloc topstoriesBloc = TopstoriesBloc();
