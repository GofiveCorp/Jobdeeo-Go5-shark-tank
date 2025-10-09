class PreferencesService {
  static bool _questionnaireCompleted = false;
  static List<String> _jobPositions = [];

  static Future<void> setQuestionnaireCompleted() async {
    _questionnaireCompleted = true;
  }

  static Future<bool> isQuestionnaireCompleted() async {
    return _questionnaireCompleted;
  }

  static Future<void> setJobPositions(List<String> positions) async {
    _jobPositions = positions;
  }

  static Future<List<String>> getJobPositions() async {
    return _jobPositions;
  }

  static Future<void> reset() async {
    _questionnaireCompleted = false;
    _jobPositions = [];
  }
}