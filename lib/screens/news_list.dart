import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/topStories_bloc.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: topstoriesBloc.fetchTodIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, int index) {
                topstoriesBloc.fetchItems(snapshot.data![index]);

                return NewsListTile(
                  itemId: snapshot.data![index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
