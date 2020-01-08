class StringUtil {

  /// Check string is empty
  /// param (value)
  static bool isEmpty(String value) {
    /// In the case value is null
    if (value == null) {
      return true;
    }
    /// In the case value is empty
    if (value.isEmpty || value.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
