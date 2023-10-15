class ExpenseModel {
  final String title;
  final DateTime date;
  final double value;
  final bool isSubmitted;

  ExpenseModel({
    required this.title,
    required this.date,
    required this.value,
    required this.isSubmitted,
  });
}
