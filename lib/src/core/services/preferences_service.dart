class PreferencesService {
  static bool _questionnaireCompleted = false;

  static Future<void> setQuestionnaireCompleted() async {
    _questionnaireCompleted = true;
  }

  static Future<bool> isQuestionnaireCompleted() async {
    return _questionnaireCompleted;
  }

  static Future<void> reset() async {
    _questionnaireCompleted = false;
  }
}