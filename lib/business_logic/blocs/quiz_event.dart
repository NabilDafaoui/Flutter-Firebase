import '../../data/models/question.dart';

/// Abstract class for all quiz events
abstract class QuizEvent {}

/// Event to load questions from repository
class LoadQuestions extends QuizEvent {}

/// Event to start the quiz with a given set of questions
class StartQuiz extends QuizEvent {
  final List<Question> questions;
  StartQuiz({required this.questions});
}

/// Event to submit an answer (correct or not)
class SubmitAnswer extends QuizEvent {
  final bool isCorrect;
  SubmitAnswer({required this.isCorrect});
}

/// Event to restart the quiz
class RestartQuiz extends QuizEvent {}
