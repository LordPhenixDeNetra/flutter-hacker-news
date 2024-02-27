import 'package:flutter/material.dart';

class NAppBar extends StatelessWidget implements PreferredSizeWidget{

  // Définissez une hauteur préférée pour votre AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const NAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 42,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "T I T L E",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.search, color: Colors.white,),
        ],
      ),
    );
  }
}
