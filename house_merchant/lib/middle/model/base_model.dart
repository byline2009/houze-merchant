import 'package:equatable/equatable.dart';

class PageModel  {

  int count;
  String next;
  String previous;
  dynamic results;

  PageModel({this.count, this.next, this.previous, this.results});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'],
    );
  }

  PageModel.map(dynamic obj) {
    this.count = obj['count'];
    this.next = obj['next'];
    this.previous = obj['previous'];
    this.results = obj['results'];
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results,
  };

}

class IdNameModel extends Equatable {
  final String id;
  final String name;

  IdNameModel({
    this.id,
    this.name,
  });

  factory IdNameModel.fromJson(Map<String, dynamic> json) => json != null
      ? new IdNameModel(
          id: json["id"],
          name: json["name"],
        )
      : null;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}