class ExpenseModel {
  final String id;
  final String description;
  final String expenseDate;
  final num amount;
  final String? latitude;
  final String? longitude;

  final bool isSubmitted;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.expenseDate,
    required this.amount,
    this.latitude,
    this.longitude,
    required this.isSubmitted,
  });

  ExpenseModel copyWith({
    String? id,
    String? description,
    String? expenseDate,
    num? amount,
    String? latitude,
    String? longitude,
    bool? isSubmitted,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      description: description ?? this.description,
      expenseDate: expenseDate ?? this.expenseDate,
      amount: amount ?? this.amount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  DateTime get asDate => DateTime.parse(expenseDate);
}
