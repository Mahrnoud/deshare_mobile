// ============================================================================
// FILE: lib/models/store.dart
// ============================================================================
class Store {
  final String type;
  final String name;
  final String hotline;

  Store({
    required this.type,
    required this.name,
    required this.hotline,
  });

  Map<String, dynamic> toJson() => {
    'type': type,
    'name': name,
    'hotline': hotline,
  };

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    type: json['type'],
    name: json['name'],
    hotline: json['hotline'],
  );
}
