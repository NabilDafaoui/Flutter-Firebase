import 'package:flutter/material.dart';
import '../../data/models/question.dart';
import '../../data/repositories/question_repository.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  bool _isCorrectAnswer = false;
  String _selectedImage = 'default.png'; // Image par défaut

  final QuestionRepository _repository = QuestionRepository();

  // Liste des images disponibles dans le dossier assets
  final List<String> _availableImages = ['default.png', 'image1.png', 'image2.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Texte de la question'),
                validator: (value) => value!.isEmpty ? 'Champ obligatoire' : null,
              ),
              CheckboxListTile(
                title: Text('Réponse correcte ?'),
                value: _isCorrectAnswer,
                onChanged: (value) {
                  setState(() {
                    _isCorrectAnswer = value!;
                  });
                },
              ),
              DropdownButton<String>(
                value: _selectedImage,
                items: _availableImages.map((String image) {
                  return DropdownMenuItem<String>(
                    value: image,
                    child: Text(image),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedImage = newValue!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Question newQuestion = Question(
                      questionText: _questionController.text,
                      isCorrectAnswer: _isCorrectAnswer,
                      imagePath: 'assets/images/$_selectedImage',
                    );
                    await _repository.addQuestion(newQuestion);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Question ajoutée avec succès !')),
                    );
                    _questionController.clear();
                    setState(() {
                      _isCorrectAnswer = false;
                      _selectedImage = 'default.png';
                    });
                  }
                },
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
