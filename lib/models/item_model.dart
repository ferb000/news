import 'dart:convert';

class ItemModel {
  late int id;
  late bool deleted;
  late String type;
  late String by;
  late int time;
  late String text;
  late bool dead;
  late int parent;
  late List<dynamic> kids;
  late String url;
  late int score;
  late String title;
  late int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'] ?? 0;
    deleted = parsedJson['deleted'] ?? false;
    type = parsedJson['type'] ?? "unknown";
    by = parsedJson['by'] ?? 'anonymous';
    time = parsedJson['time'] ?? 0;
    text = parsedJson['text'] ?? '';
    dead = parsedJson['dead'] ?? false;
    parent = parsedJson['parent'] ?? 0;
    kids = parsedJson['kids'] ?? [];
    url = parsedJson['url'] ?? ''.toString();
    score = parsedJson['score'] ?? 0;
    title = parsedJson['title'] ?? "no title";
    descendants = parsedJson['descendants'] ?? 0;
  }

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
