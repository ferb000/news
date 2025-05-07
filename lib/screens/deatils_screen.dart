import "package:flutter/material.dart";
import 'package:news/models/item_model.dart';
import '../blocs/comments_bloc.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;
  const NewsDetails({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[200],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: commentsBloc.itemWithComments,
            builder: (context,
                AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
              final itemFuture = snapshot.data?[itemId];
              return FutureBuilder(
                future: itemFuture,
                builder: (context, itemSnapshot) {
                  return buildTitle(itemSnapshot.data);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTitle(ItemModel? item) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Text(
            '${item?.title}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text("${item?.text}"),
      ],
    );
  }
}
