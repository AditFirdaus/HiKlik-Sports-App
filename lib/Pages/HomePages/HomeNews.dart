import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/HomePage.dart';
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
    log("rebuild");
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
          future: FireDatabase.getNews(category: HomePage.categoryType),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NewsData>? cachedNews = snapshot.data;
              return ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  itemCount: cachedNews!.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return NewsCard(cachedNews[index]);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(PageTransition(
            type: PageTransitionType.size,
            curve: Curves.easeInOutQuart,
            childCurrent: this,
            alignment: Alignment.center,
            child: NewsPage(_newsData),
            duration: const Duration(milliseconds: 500),
          ));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 192,
                  height: 128,
                  child: CachedNetworkImage(
                    imageUrl: _newsData.featured_image,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                            child: CircularProgressIndicator(
                      value: progress.progress,
                    )),
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
                          maxLines: 3,
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
  String featured_image = "";
  String title = "";
  String content = "";

  NewsData(this.featured_image, this.title, this.content);

  NewsData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("featured_image")) featured_image = json['featured_image'];
    if (json.containsKey("title")) title = json['title'];
    if (json.containsKey("content")) content = json['content'];
  }

  Map<String, String> toJson() => {
        'image_url': featured_image,
        'title': title,
        'content': content,
      };
}
