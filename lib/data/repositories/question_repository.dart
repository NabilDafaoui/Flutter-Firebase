import '../../presentation/services/FirestoreService.dart';
import '../models/question.dart';

class QuestionRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<Question>> fetchQuestions() async {
    try {
      return await _firestoreService.fetchQuestions();
    } catch (e) {
      throw Exception('Erreur dans QuestionRepository : $e');
    }
  }


  Future<void> addQuestion(Question question) {
    return _firestoreService.addQuestion(question);
  }
}
