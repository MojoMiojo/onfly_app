import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:onfly_app/presentation/utils/onfly_colors.dart';

class OnflyTextField extends StatelessWidget {
  final Key formKey;
  final String? initialValue;
  final String fieldName;
  final String hintText;
  final List<TextInputFormatter>? masks;
  final Function(String?)? onChanged;
  final String? Function(String?)? validate;
  final TextInputType? inputType;
  final TextEditingController controller;
  
  const OnflyTextField({
    Key? key,
    required this.formKey,
    this.initialValue,
    required this.fieldName,
    required this.hintText,
    this.masks,
    this.onChanged,
    this.validate,
    this.inputType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
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
              controller: controller,
              initialValue: initialValue,
              inputFormatters: masks,
              onChanged: onChanged,
              validator: validate,
              keyboardType: inputType,
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
      ),
    );
  }
}
