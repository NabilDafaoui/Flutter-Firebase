import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/question.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Récupérer les questions
  Future<List<Question>> fetchQuestions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('questions').get();

      // Ajout de l'affichage des données pour vérification
      snapshot.docs.forEach((doc) {
        print("Document ID: ${doc.id}, Data: ${doc.data()}");
      });

      // Le reste de votre code pour traiter les questions...
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          String questionText = data['questionText'] as String? ?? '';
          bool isCorrectAnswer = data['isCorrectAnswer'] as bool? ?? false;
          String imagePath = data['imagePath'] as String? ?? '';

          return Question(
            questionText: questionText,
            isCorrectAnswer: isCorrectAnswer,
            imagePath: imagePath,
          );
        } else {
          throw Exception('Document ne contient pas les champs nécessaires ou types incorrects');
        }
      }).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des questions : $e');
    }
  }


  // Ajouter une nouvelle question
  Future<void> addQuestion(Question question) async {
    try {
      await _firestore.collection('questions').add({
        'questionText': question.questionText,
        'isCorrectAnswer': question.isCorrectAnswer,
        'imagePath': question.imagePath,
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de la question : $e');
    }
  }
}
