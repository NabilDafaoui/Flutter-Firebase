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
  String _selectedImage = 'default.png';

  final QuestionRepository _repository = QuestionRepository();

  final List<String> _availableImages = [
    'default.png',
    'image1.png',
    'image2.png'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une question'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nouvelle Question",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: 'Texte de la question',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.question_answer),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Champ obligatoire' : null,
                    ),
                    SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text('Réponse correcte ?'),
                      value: _isCorrectAnswer,
                      onChanged: (value) {
                        setState(() {
                          _isCorrectAnswer = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedImage,
                      decoration: InputDecoration(
                        labelText: 'Sélectionner une image',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.image),
                      ),
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
                    SizedBox(height: 20),
                    if (_selectedImage.isNotEmpty)
                      Image.asset(
                        'assets/images/$_selectedImage',
                        height: 100,
                      ),
                    SizedBox(height: 20),
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
                            SnackBar(
                                content:
                                Text('Question ajoutée avec succès !')),
                          );
                          _questionController.clear();
                          setState(() {
                            _isCorrectAnswer = false;
                            _selectedImage = 'default.png';
                          });
                        }
                      },
                      child: Text('Ajouter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
