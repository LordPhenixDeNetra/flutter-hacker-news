import 'package:flutter/material.dart';
import 'package:n_hacker_news/services/ThemeProvider.dart';
import 'package:provider/provider.dart';

class NAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Définissez une hauteur préférée pour votre AppBar
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const NAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.sunny
                  : Icons.nightlight,
            ),
          )
          // Icon(Icons.search, color: Colors.white,),
        ],
      ),
    );
  }
}
