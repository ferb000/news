import 'package:flutter/material.dart';
import 'package:news/blocs/comments_provider.dart';
import 'package:news/screens/deatils_screen.dart';
import '../screens/news_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: MaterialApp(
        title: "News",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          // final commentsBloc = CommentsProvider.of(context);
          int itemId = int.parse(settings.name!.replaceFirst('/', ''));
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetails(
            itemId: itemId,
          );
        },
      );
    }
  }
}
