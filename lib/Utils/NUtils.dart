import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NUtils {
  static String formatTimestamp(int timestamp) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      // Même jour que le jour courant
      return DateFormat('HH:mm').format(date);
    } else if (difference.inDays < 7) {
      // Même semaine que la semaine courante
      return DateFormat('EEE').format(date);
    } else if (date.year == now.year) {
      // Même année que l'année courante
      return DateFormat('dd MMM').format(date);
    } else {
      // Année différente de l'année courante
      return DateFormat('dd/MM/yy').format(date);
    }
  }

  static String formatNameForProfile(String text) {
    return (text[0] + text[text.length - 1]).toUpperCase();
  }

  static List<int> parseIntList(String input) {
    final List<int> result = [];
    const pattern = r'\d+'; // Regex pattern pour trouver les nombres entiers
    final matches = RegExp(pattern).allMatches(input);

    for (final match in matches) {
      final number = int.parse(match.group(0)!);
      result.add(number);
    }

    return result;
  }

  static List<int?> parseDynamicNumbers(List<dynamic> dynamics) {
    return dynamics
        .map((dynamics) => int.tryParse(dynamics.toString()))
        .where((num) => num != null)
        .toList();
  }

  static String reformatText(String text) {
  // Remplacer les balises HTML par des caractères spéciaux
  String formattedText = text.replaceAll(RegExp(r'<[^>]*>'), '');

  // Remplacer les caractères HTML spéciaux par leurs équivalents
  formattedText = formattedText.replaceAll('&quot;', '"');
  formattedText = formattedText.replaceAll('&amp;', '&');
  formattedText = formattedText.replaceAll('&lt;', '<');
  formattedText = formattedText.replaceAll('&gt;', '>');
  formattedText = formattedText.replaceAll('&apos;', '\'');
  formattedText = formattedText.replaceAll('&#x27;', '\'');

  return formattedText;
}

static final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.amber,
    Colors.lime,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.lightBlueAccent,
    Colors.amberAccent,
    Colors.limeAccent,
    Colors.brown,
  ];

  static Color getRandomColor() {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }


}
