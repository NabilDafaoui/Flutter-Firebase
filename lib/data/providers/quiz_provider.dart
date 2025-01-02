import 'package:flutter/material.dart';
import '../models/question.dart';
import '../repositories/question_repository.dart';

class QuestionProvider extends ChangeNotifier {
  final QuestionRepository _repository = QuestionRepository();

  List<Question> _questions = [];
  bool _isLoading = false;
  String? _error;

  List<Question> get questions => _questions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadQuestions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _questions = await _repository.fetchQuestions();
    } catch (e) {
      _error = "Failed to load questions";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
