import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _loadCurrentAvatar();
  }

  Future<void> _loadCurrentAvatar() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _selectedAvatar = doc.data()?['avatarPath'];
        });
      }
    }
  }

  Future<void> _selectAvatar(String avatarPath) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).set({
        'avatarPath': avatarPath,
      }, SetOptions(merge: true));

      setState(() {
        _selectedAvatar = avatarPath;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Avatar mis à jour avec succès')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la mise à jour de l\'avatar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil Utilisateur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _selectedAvatar != null ? AssetImage(_selectedAvatar!) : null,
              child: _selectedAvatar == null ? Icon(Icons.person, size: 60) : null,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 1; i <= 4; i++)
                  GestureDetector(
                    onTap: () => _selectAvatar('assets/avatars/avatar$i.jpg'),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avatars/avatar$i.jpg'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
