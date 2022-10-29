import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/HomePages/HomeNews.dart';

class NewsPage extends StatelessWidget {

  NewsData _newsData;

  NewsPage(this._newsData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(128),
            child: FloatingAppBar(
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: const Color(0xFF303030),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              bottom: 32,
              ),
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              children: [
                Text(
                  _newsData.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: _newsData.featured_image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                Html(
                  data: _newsData.content
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
