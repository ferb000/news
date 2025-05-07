import 'package:flutter/material.dart';
import 'package:news/widgets/loading_shimmer.dart';
import '../models/item_model.dart';
import '../blocs/topStories_bloc.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({required this.itemId, super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: topstoriesBloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingShimmer();
        }

        return FutureBuilder(
          future: /* news.fetchItems(itemId),*/ snapshot.data?[itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (itemSnapshot.connectionState == ConnectionState.waiting) {
              return const LoadingShimmer();
            }

            return buildTile(itemSnapshot.data, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel? item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('${item?.title}'),
          subtitle: Text('${item?.score} points'),
          trailing: Column(
            children: [
              const Icon(Icons.comment_outlined),
              Text("${item?.descendants}"),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed('${item?.id}');
            print("item id ${item?.id} was pressed");
          },
        ),
        const Divider(
          color: Colors.blueAccent,
        ),
      ],
    );
  }
}
