part of '../home_page.dart';

class _HomeExpenseCard extends StatefulWidget {
  final ExpenseModel expense;

  const _HomeExpenseCard({
    required this.expense,
  });

  @override
  State<_HomeExpenseCard> createState() => _HomeExpenseCardState();
}

class _HomeExpenseCardState extends State<_HomeExpenseCard> {
  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
      child: Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.expense.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.expense.date.brazillianDateFormat(),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.expense.value.formatToMoney(),
                    ),
                    const SizedBox(height: 8),
                    Visibility.maintain(
                      visible: !widget.expense.isSubmitted,
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
            const SizedBox(height: 8),
            ShowMoreAnimator(
              expand: !isCollapsed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                      'https://midia.gruposinos.com.br/_midias/jpg/2021/03/11/mgid_arc_content_shared_southpark-19506257.jpg',
                      height: 112,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: OnflyCircularLoading(),
                    );
                  }),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OnflyFilledButton(
                          onPressed: () {},
                          child: const Text('Editar'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OnflyFilledButton(
                          onPressed: () {},
                          child: const Text('Apagar'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
