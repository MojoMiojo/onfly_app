import 'package:flutter/material.dart';
import 'package:onfly_app/presentation/widgets/widgets.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const OnflyAppBar(
          title: 'Adicionar despesa',
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            const OnflyTextField(
              fieldName: 'Descrição',
              hintText: 'Almoço',
            ),
            const SizedBox(height: 8),
            const OnflyTextField(
              fieldName: 'Data da despesa',
              hintText: '15/10/2023',
            ),
            const SizedBox(height: 8),
            const OnflyTextField(
              fieldName: 'Valor',
              hintText: '34,15',
            ),
            const SizedBox(height: 24),
            OnflyFilledButton(
              onPressed: () {},
              padding: 16,
              child: const Text('Adicionar'),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.photo_camera_rounded),
        ),
      ),
    );
  }
}
