class HistoryCategory {
  final int id;
  final String name;
  final int fromAll;
  final int spent;

  HistoryCategory({
    required this.id,
    required this.name,
    required this.fromAll,
    required this.spent,
  });

  factory HistoryCategory.fromJson(Map<String, dynamic> json) {
    return HistoryCategory(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      fromAll: json['from_all'] as int? ?? 0,
      spent: json['spent'] as int? ?? 0,
    );
  }
}

class Summary {
  final int totalSpent;
  final int totalReceived;
  final List<HistoryCategory> categories;

  Summary({
    required this.totalSpent,
    required this.totalReceived,
    required this.categories,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    var categoriesList = json['categories'] as List<dynamic>? ?? [];
    List<HistoryCategory> categories =
    categoriesList.map((categoryJson) => HistoryCategory.fromJson(categoryJson)).toList();

    return Summary(
      totalSpent: json['total_spent'] as int? ?? 0,
      totalReceived: json['total_received'] as int? ?? 0,
      categories: categories,
    );
  }
}
