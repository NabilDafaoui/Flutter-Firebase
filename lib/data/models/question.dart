class Question {
  final String questionText;
  final bool isCorrectAnswer;
  final String imagePath;

  Question({
    required this.questionText,
    required this.isCorrectAnswer,
    this.imagePath = '',  // Valeur par défaut pour imagePath
  });
}
