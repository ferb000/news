import 'package:flutter/material.dart';
import '../blocs/topStories_bloc.dart';

class Refresh extends StatelessWidget {
  Widget child;
  Refresh({required this.child, super.key});

  @override
  Widget build(context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await topstoriesBloc.clearCache();
        await topstoriesBloc.fetchTopIds();
      },
    );
  }
}
