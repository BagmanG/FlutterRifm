import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {

  final List<Article> _articles = [];
  final Uri _url = Uri.parse('https://t.me/bagmanApps');

  @override
  void initState() {
    // TODO: implement initState
    loadNews();
    super.initState();
  }

  void loadNews() async {
    http.get(Uri.parse('https://bagmanov.com/rifme_home.php')).then((response) {
      setState(() {
        String result = response.body;
        var splitted = result.split('~');
        splitted.removeLast();
        for(int i = 0;i<splitted.length;i++){
          var params = splitted[i].split('|');
          _articles.add(Article(title: params[0], imageUrl: "https://bagmanov.com/rifmeImages/"+params[2], author: "Rifme", postedOn: params[1]));
        }
      });
    }).catchError((error){
      print("Error: $error");
    });
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: _articles.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _articles[index];
              return InkWell(
                onTap: _launchUrl,
                child: Container(
                  height: 136,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text("${item.author} · ${item.postedOn}",
                                  style: Theme.of(context).textTheme.caption),
                              const SizedBox(height: 8),
                            ],
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.imageUrl),
                              ))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {required this.title,
        required this.imageUrl,
        required this.author,
        required this.postedOn});
}