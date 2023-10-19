class TextInputValidators {
  static String? validateDecriptionField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can`t be empty';
    } else if (value.length > 50) {
      return 'Maximum 50 characters allowed';
    }
    return null;
  }

  static String? validateDateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can`t be empty';
    } else if (value.length < 10) {
      return 'Invalid format';
    } else {
      try {
        var toParse = '';
        var splitted = value.split('/');

        toParse += splitted.last;
        toParse += splitted.elementAt(1);
        toParse += splitted.first;

        var date = DateTime.parse(toParse);

        if (date.day < 1 ||
            date.day > 31 ||
            date.month < 1 ||
            date.month > 12) {
          return 'Invalid format';
        }

        return null;
      } catch (e) {
        return 'Invalid format';
      }
    }
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Can`t be empty';
    } else if (value.length > 10) {
      return 'Invalid format';
    } else {
      try {
        double.parse(value.replaceAll(',', '.'));
        return null;
      } catch (e) {
        return 'Invalid format';
      }
    }
  }
}
