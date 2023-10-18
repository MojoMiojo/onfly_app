import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextInputMasks {
  static MaskTextInputFormatter get brazillianDateMask =>
      MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );

  static FilteringTextInputFormatter get amountFields =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'));
}
