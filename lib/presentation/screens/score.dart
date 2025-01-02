import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../business_logic/blocs/quiz_bloc.dart';
import '../../business_logic/blocs/quiz_event.dart';
import '../../data/repositories/question_repository.dart';
import 'home.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScorePage({Key? key, required this.score, required this.totalQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVictory = score >= totalQuestions * 0.4;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                isVictory
                    ? "lib/presentation/animations/congratulations.json"
                    : "lib/presentation/animations/loser.json",
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                isVictory ? "Félicitations !" : "Dommage...",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                "Votre score : $score / $totalQuestions",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => QuizBloc(QuestionRepository()),
                        child: const HomePage(),
                      ),
                    ),
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text("Rejouer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
