import 'package:news/resources/class_api.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

void main() {
  test(
    'fetching all top storries returns a list of ids',
    () async {
      // setup of the code to test
      final newsApi = NewsApiProvider();
      newsApi.client = MockClient(
        (request) async {
          return Response(json.encode([1, 2, 3, 4]), 200);
        },
      );

      final topStories = await newsApi.fetchTopIds();
      //expectation of the test
      expect(topStories, [1, 2, 3, 4]);
    },
  );

  test(
    'Fetching individual store returns an itemmodel',
    () async {
      // setup
      final newsApi = NewsApiProvider();
      newsApi.client = MockClient(
        (request) async {
          return Response(json.encode({'id': 123}), 200);
        },
      );

      final items = await newsApi.fetchItems(999);

      // expectation
      expect(items.id, 123);
    },
  );
}
