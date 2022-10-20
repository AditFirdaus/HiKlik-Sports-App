import 'dart:html';

class UserData {
  static UserData instance = UserData(
    "https://firebasestorage.googleapis.com/v0/b/hiklik-sports-76bdd.appspot.com/o/107502-Anna%20KUN.jpg?alt=media&token=14bb4aa8-b062-47d0-83ed-14ef3a1f94cd",
    "[Member Name]",
    "[Member Description]",
    "[Member About]",
    {},
    {},
  );

  late String uid;

  String avatar = "";
  String name = "";
  String description = "";
  String about = "";
  Map<String, dynamic> achivements = {};
  Map<String, dynamic> galleryImages = {};

  UserData(
    this.avatar,
    this.name,
    this.description,
    this.about,
    this.achivements,
    this.galleryImages,
  );

  UserData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    description = json['description'];
    about = json['about'];
    achivements = json['achivements'];
    galleryImages = json['galleryImages'];
  }

  Map<String, dynamic> toJson() => {
    'avatar': avatar,
    'name': name,
    'description': description,
    'about': about,
    'achivements': achivements,
    'galleryImages': galleryImages,
  };
  
  static fromUID(String uid)
  {
    
  }
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
