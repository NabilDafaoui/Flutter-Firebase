import 'package:flutter/material.dart';

class AvatarBar extends StatelessWidget implements PreferredSizeWidget {
  final String avatarPath;
  final double height = 60.0;

  const AvatarBar({Key? key, required this.avatarPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(8),
      color: Colors.black.withOpacity(0.5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            radius: 20,
          ),
          SizedBox(width: 10),
          Text(
            'Joueur',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
