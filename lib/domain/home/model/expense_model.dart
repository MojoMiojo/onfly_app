class ExpenseModel {
  final String id;
  final String description;
  final String expenseDate;
  final num amount;
  final String? latitude;
  final String? longitude;

  final bool isSubmitted;
  final bool isEditPending;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.expenseDate,
    required this.amount,
    this.latitude,
    this.longitude,
    required this.isSubmitted,
    this.isEditPending = false,
  });

  ExpenseModel.create({
    required this.id,
    required this.description,
    required this.expenseDate,
    required this.amount,
    this.latitude,
    this.longitude,
    this.isSubmitted = false,
    this.isEditPending = false,
  });

  ExpenseModel copyWith({
    String? id,
    String? description,
    String? expenseDate,
    num? amount,
    String? latitude,
    String? longitude,
    bool? isSubmitted,
    bool? isEditPending,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      description: description ?? this.description,
      expenseDate: expenseDate ?? this.expenseDate,
      amount: amount ?? this.amount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isEditPending: isEditPending ?? this.isEditPending,
    );
  }

  DateTime get asDate => DateTime.parse(expenseDate);
}
