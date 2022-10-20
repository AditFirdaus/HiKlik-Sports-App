import 'dart:convert';

import 'package:sports/Pages/Widgets/AchivementView.dart';

class UserData {
  late String uid;

  late String avatar = "";
  late String name = "";
  late String description = "";
  late String about = "";
  late List<UserAchivement> achivement = [];
  late List<UserGalleryImage> galleryImage = [];

  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    description = json['description'];
    about = json['about'];

    List<dynamic> _achivementData = jsonDecode(json['achivement']);
    List<UserAchivement> achivementData = [];
    _achivementData.forEach(
    (element) 
      { 
        achivementData.add(UserAchivement.fromJson(element as Map<String, dynamic>));
      }
    );

    achivement = achivementData;

    List<dynamic> _galleryImageData = jsonDecode(json['achivement']);
    List<UserGalleryImage> galleryImageData = [];
    _achivementData.forEach(
    (element) 
      { 
        galleryImageData.add(UserGalleryImage.fromJson(element as Map<String, dynamic>));
      }
    );
    galleryImage = galleryImageData;
  }

  Map<String, String> toJson() => {
    'avatar': avatar,
    'name': name,
    'description': description,
    'about': about,
    'achivement': jsonEncode(achivement),
    'galleryImage': jsonEncode(galleryImage),
  };
}

class UserAchivement {
  String title = "";
  String description = "";

  UserAchivement(this.title, this.description);

  UserAchivement.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}

class UserGalleryImage {
  String imageUrl = "";

  UserGalleryImage(this.imageUrl);

  UserGalleryImage.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
  };
}
