import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/blocs/quiz_event.dart';
import '../../business_logic/blocs/quiz_state.dart';
import 'AvatarBar.dart';

class QuestionCard extends StatelessWidget {
  final QuizLoaded state;
  final String avatarPath;

  const QuestionCard({required this.state, required this.avatarPath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentQuestion = state.questions[state.currentQuestionIndex];

    return Column(
      children: [
        AvatarBar(avatarPath: avatarPath),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          currentQuestion.questionText,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (currentQuestion.imagePath.isNotEmpty)
                      Image.asset(
                        currentQuestion.imagePath,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _submitAnswer(context, true),
                      child: const Text("Vrai"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _submitAnswer(context, false),
                      child: const Text("Faux"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitAnswer(BuildContext context, bool userAnswer) {
    context.read<QuizBloc>().add(
      SubmitAnswer(
        isCorrect: userAnswer ==
            state.questions[state.currentQuestionIndex].isCorrectAnswer,
      ),
    );
  }
}
