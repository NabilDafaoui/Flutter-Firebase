import '../../data/models/question.dart';

/// Abstract class for all quiz states
abstract class QuizState {}

/// Initial state before anything happens
class QuizInitial extends QuizState {}

/// State while questions are loading
class QuizLoading extends QuizState {}

/// State when questions are loaded and quiz is active
class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;

  QuizLoaded({
    required this.questions,
    this.currentQuestionIndex = 0,
    this.score = 0,
  });
}

/// State when the quiz is completed
class QuizCompleted extends QuizState {
  final int score;
  final int totalQuestions;

  QuizCompleted({
    required this.score,
    required this.totalQuestions,
  });
}

/// State when an error occurs
class QuizError extends QuizState {
  final String message;
  QuizError({required this.message});
}
