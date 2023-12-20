class FieldsValidation {
  static String? emailFieldValidation(String fieldData) {
    if (fieldData.isEmpty) {
      return "Field Must be Filled";
    }
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    bool value = regExp.hasMatch(fieldData);
    if (!value) {
      return "Email badly format";
    }
    return null;
  }

  static String? emptyFieldValidation(String fieldData) {
    if (fieldData.isEmpty)
      return "Field Must be Filled";
    else
      return null;
  }
}
