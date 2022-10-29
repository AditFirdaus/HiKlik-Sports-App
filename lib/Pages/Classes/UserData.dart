import 'dart:convert';

class UserData {
  late String uid = "";

  late String avatar = "";
  late String name = "";
  late String description = "";
  late String about = "";
  late String sport = "";
  late String job = "";
  late List<UserAchivement> achivement = [];
  late List<UserGalleryImage> galleryImage = [];

  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    
    if (json.containsKey("uid")) uid = json["uid"];
    if (json.containsKey("avatar")) avatar = json['avatar'];
    if (json.containsKey("name")) name = json['name'];
    if (json.containsKey("description")) description = json['description'];
    if (json.containsKey("about")) about = json['about'];
    if (json.containsKey("sport")) sport = json['sport'];
    if (json.containsKey("job")) job = json['job'];

    List<dynamic> achivementData = jsonDecode(json['achivement']);
    List<UserAchivement> achivementDataList = [];
    for (var element in achivementData) {
      achivementDataList
          .add(UserAchivement.fromJson(element as Map<String, dynamic>));
    }

    achivement = achivementDataList;

    List<dynamic> galleryImageData = jsonDecode(json['galleryImage']);
    List<UserGalleryImage> galleryImageDataList = [];
    for (var element in galleryImageData) {
      galleryImageDataList
          .add(UserGalleryImage.fromJson(element as Map<String, dynamic>));
    }
    galleryImage = galleryImageDataList;
  }

  Map<String, String> toJson() => {
    'uid': uid,
    'avatar': avatar,
    'name': name,
    'description': description,
    'about': about,
    'sport': sport,
    'job': job,
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
