import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository_provider.dart';

class CommentsBloc {
  final _repository = RepositoryProvider();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  Stream<Map<int, Future<ItemModel?>>> get itemWithComments {
    return _commentsOutput.stream;
  }

  Function(int) get fetchItemWithComments {
    return _commentsFetcher.sink.add;
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
        (cache, int id, _) {
      print('$_ yess you ');
      cache[id] = _repository.fetchItem(id);
      cache[id]!.then((ItemModel? item) {
        //
        item?.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });
      return cache;
    }, <int, Future<ItemModel?>>{});
  }

  CommentsBloc() {
    //
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }
}

CommentsBloc commentsBloc = CommentsBloc();
