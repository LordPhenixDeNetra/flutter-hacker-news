import 'package:flutter/material.dart';
import 'package:n_hacker_news/Models/Story.dart';
import 'package:n_hacker_news/Utils/NUtils.dart';
import 'package:n_hacker_news/Widgets/NListAnimated.dart';
import 'package:n_hacker_news/services/DatabaseHelperProvider.dart';
import 'package:provider/provider.dart'; // Importer DatabaseHelperProvider

class OffLineNewsPage extends StatelessWidget {
  const OffLineNewsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Off Line Stories"),
      ),
      body: FutureBuilder<List<Story>>(
        future: Provider.of<DatabaseHelperProvider>(context)
            .getAllArticles(), // Appeler la méthode getAllArticles()
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Une erreur s\'est produite'));
          } else {
            final articles = snapshot.data!;
            // Utilisez les données récupérées ici pour construire votre widget
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                print(article.isFavorite);

                return Column(
                  children: [
                    NListAnimated(     
                        url: article.url ?? "No URL",
                        user: article.userId ?? "No Text",
                        index: index,
                        animatedListView: true,
                        subtitle: article.title! ?? "No Text",
                        score: article.score ?? 0,
                        intToDate: NUtils.formatTimestamp(article.commentTime ?? 0),
                        story: article, onOffLine: true,
                      ),

                      Divider()
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
