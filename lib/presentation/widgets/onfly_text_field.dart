import 'package:flutter/material.dart';
import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflyTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;

  const OnflyTextField({
    super.key,
    required this.fieldName,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: OnflyColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: const [
              BoxShadow(
                blurRadius: 0.4,
                spreadRadius: 0.8,
                offset: Offset(0, 1),
                color: Colors.black12,
              )
            ],
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: OnflyColors.brandPrimary,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
