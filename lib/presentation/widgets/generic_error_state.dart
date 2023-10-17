import 'package:flutter/material.dart';

import 'package:onfly_app/presentation/utils/onfly_colors.dart';
import 'package:onfly_app/presentation/widgets/widgets.dart';

class GenericErrorState extends StatelessWidget {
  final Function onTryAgain;
  final String? errorMessage;

  const GenericErrorState({
    Key? key,
    required this.onTryAgain,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OnflyAppBar(
        title: 'Ops..',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: OnflyColors.burntSienna,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  errorMessage ?? 'Sentimos muito, algo deu errado.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Spacer(),
              OnflyFilledButton(
                padding: 16,
                onPressed: () => onTryAgain(),
                child: const Text('Tentar novamente'),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
