import 'package:flutter/material.dart';
import 'package:sports/Pages/NewsPage.dart';
import 'package:sports/Pages/api/contents-api.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({super.key});

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: ListView(clipBehavior: Clip.none, children: [
        const Text(
          "See what's new!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3436),
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        FutureBuilder(
          future: FireDatabase.getNews(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<NewsData>? newsList = snapshot.data;

              return ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return NewsCard(newsList![index]);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ]),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsData _newsData;

  const NewsCard(this._newsData, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsPage(_newsData),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.network(
                    _newsData.image_url,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _newsData.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _newsData.content,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 8,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
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

class NewsData {
  String image_url = "";
  String title = "";
  String content = "";

  NewsData(this.image_url, this.title, this.content);

  NewsData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("image_url")) image_url = json['image_url'];
    if (json.containsKey("title")) title = json['title'];
    if (json.containsKey("content")) content = json['content'];

    image_url =
        "https://alxgroup.com.au/wp-content/uploads/2016/04/dummy-post-horisontal.jpg";
  }

  Map<String, String> toJson() => {
        'image_url': image_url,
        'title': title,
        'content': content,
      };
}
