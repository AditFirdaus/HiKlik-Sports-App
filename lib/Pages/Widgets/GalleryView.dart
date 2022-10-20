import 'package:flutter/material.dart';
import 'package:sports/Pages/Widgets/ProfileCard.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      GridView(
        primary: false,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: const [
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
          GalleryViewItem('https://picsum.photos/seed/242/600'),
        ],
      ),
    );
  }
}

class GalleryViewItem extends StatelessWidget {
  final String image_url;

  const GalleryViewItem(this.image_url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image_url,
      fit: BoxFit.cover,
    );
  }
}
