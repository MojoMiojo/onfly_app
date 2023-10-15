part of '../home_page.dart';

class _HomeExpenseCard extends StatelessWidget {
  final ExpenseModel expense;

  const _HomeExpenseCard({
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: OnflyColors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 0.4,
            spreadRadius: 0.8,
            offset: Offset(0, 1),
            color: Colors.black12,
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                expense.date.brazillianDateFormat(),
              )
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.value.formatToMoney(),
              ),
              const SizedBox(height: 8),
              Visibility.maintain(
                visible: !expense.isSubmitted,
                child: Icon(
                  Icons.wifi_off_rounded,
                  color: OnflyColors.burntSienna,
                ),
              )
            ],
          ),
          const SizedBox(width: 16),
          const Icon(Icons.expand_more_rounded)
        ],
      ),
    );
  }
}
