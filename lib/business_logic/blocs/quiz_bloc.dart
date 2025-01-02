import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/question_repository.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuestionRepository questionRepository;

  QuizBloc(this.questionRepository) : super(QuizInitial()) {
    on<LoadQuestions>(_onLoadQuestions);
    on<StartQuiz>(_onStartQuiz);
    on<SubmitAnswer>(_onSubmitAnswer);
    on<RestartQuiz>(_onRestartQuiz);
  }

  Future<void> _onLoadQuestions(LoadQuestions event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final questions = await questionRepository.fetchQuestions();
      if (questions.isNotEmpty) {
        emit(QuizLoaded(questions: questions));
      } else {
        emit(QuizError(message: 'Aucune question disponible.'));
      }
    } catch (e) {
      emit(QuizError(message: 'Erreur lors du chargement des questions : ${e.toString()}'));
    }
  }


  void _onStartQuiz(StartQuiz event, Emitter<QuizState> emit) {
    emit(QuizLoaded(questions: event.questions));
  }

  void _onSubmitAnswer(SubmitAnswer event, Emitter<QuizState> emit) {
    final currentState = state;
    if (currentState is QuizLoaded) {
      int newScore = currentState.score + (event.isCorrect ? 1 : 0);
      int nextIndex = currentState.currentQuestionIndex + 1;

      if (nextIndex < currentState.questions.length) {
        emit(QuizLoaded(
          questions: currentState.questions,
          currentQuestionIndex: nextIndex,
          score: newScore,
        ));
      } else {
        emit(QuizCompleted(
          score: newScore,
          totalQuestions: currentState.questions.length,
        ));
      }
    }
  }

  void _onRestartQuiz(RestartQuiz event, Emitter<QuizState> emit) {
    emit(QuizInitial());
    add(LoadQuestions());
  }
}
