/// id : 1
/// title : "fhj"
/// created_at : 1704691064216
/// updated_at : null

class TodoList {
  TodoList({
      int? id,
      String? title, 
      num? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  TodoList.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _title;
  num? _createdAt;
  dynamic _updatedAt;
TodoList copyWith({  int? id,
  String? title,
  num? createdAt,
  dynamic updatedAt,
}) => TodoList(  id: id ?? _id,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  int? get id => _id;
  String? get title => _title;
  num? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}