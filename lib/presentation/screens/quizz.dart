import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/blocs/quiz_state.dart';
import '../widgets/AvatarBar.dart';
import '../widgets/question_card.dart';
import 'score.dart';

class QuizPage extends StatelessWidget {
  final String avatarPath;

  const QuizPage({Key? key, required this.avatarPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AvatarBar(avatarPath: avatarPath),
          Expanded(
            child: BlocBuilder<QuizBloc, QuizState>(
              builder: (context, state) {
                if (state is QuizLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is QuizLoaded) {
                  return QuestionCard(state: state, avatarPath: avatarPath);
                } else if (state is QuizCompleted) {
                  return ScorePage(score: state.score, totalQuestions: state.totalQuestions);
                } else if (state is QuizError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Unknown state'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
