import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/user-api.dart';

const List<String> listJob = <String>['member', 'athlete', 'coach'];
const List<String> listSport = <String>['anggar', 'basket', 'volley'];

class ProfileEditPage extends StatefulWidget {
  bool toHome = false;

  ProfileEditPage(this.toHome, {Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  UserData tempUserData = UserData();

  bool updatingImage = false;

  String _controllerSport = listSport.first;
  String _controllerJob = listJob.first;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerAbout = TextEditingController();

  OutlineInputBorder enabeledBorder = const OutlineInputBorder(
      borderSide: BorderSide(
    color: Color(0x80000000),
    width: 1,
  ));
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0x80000000),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  );
  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  );
  OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0x00000000),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  @override
  void initState() {
    super.initState();
    CreateTempUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? file;
  FileImage? fileImage;

  Future pickImage() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick == null) return;
      file = File(pick.path);
      fileImage = FileImage(file!);
    });
  }

  Future<String> uploadImage() async {
    String downloadUrl = tempUserData.avatar;

    try {
      if (file != null) {
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('avatars/${FireUser.user?.uid}')
            .putFile(file!);

        downloadUrl = await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      log('Failed to upload image: $e');
    }

    return downloadUrl;
  }

  void CreateTempUserData() {
    final currentUserData = FireUser.currentUserData;
    tempUserData = UserData();
    tempUserData.avatar = currentUserData.avatar;
    tempUserData.uid = currentUserData.uid;
    tempUserData.name = currentUserData.name;
    tempUserData.description = currentUserData.description;
    tempUserData.about = currentUserData.about;
    tempUserData.sport = currentUserData.sport;
    tempUserData.job = currentUserData.job;
    tempUserData.achivement = currentUserData.achivement;
    tempUserData.galleryImage = currentUserData.galleryImage;

    _controllerSport = tempUserData.sport;
    _controllerUsername.text = tempUserData.name;
    _controllerDescription.text = tempUserData.description;
    _controllerAbout.text = tempUserData.about;
    _controllerJob = tempUserData.job;

    if (_controllerSport == "") _controllerSport = listSport.first;
    if (_controllerJob == "") _controllerJob = listJob.first;
  }

  void Back() {
    if (widget.toHome) {
      Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.rightToLeftJoined,
        curve: Curves.easeInOutQuart,
        childCurrent: widget,
        child: const HomePage(),
        duration: const Duration(milliseconds: 750),
      ));
    } else {
      Navigator.of(context).pop();
    }
  }

  Future Save() async {
    tempUserData.name = _controllerUsername.text;
    tempUserData.description = _controllerDescription.text;
    tempUserData.about = _controllerAbout.text;
    tempUserData.sport = _controllerSport;
    tempUserData.job = _controllerJob;

    setState(() {
      updatingImage = true;
    });

    String url = await uploadImage();

    tempUserData.avatar = url;

    setState(() {
      updatingImage = false;
    });

    FireUser.currentUserData = tempUserData;

    await FireUser.SyncUp();
    Navigator.pop(context);
  }

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
                  IconButton(onPressed: Back, icon: const Icon(Icons.cancel)),
                  DropdownButton<String>(
                    value: _controllerSport,
                    elevation: 16,
                    style: const TextStyle(
                        color: Color(0xFF303030),
                        fontWeight: FontWeight.bold,
                      ),
                    onChanged: (String? value) {
                      setState(() {
                        _controllerSport = value!;
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    itemHeight: 64,
                    items: [
                      DropdownMenuItem<String>(
                        value: "",
                        child: Row(
                          children: const [
                            Icon(Icons.cancel),
                            SizedBox(
                              width: 16,
                            ),
                            Text("None"),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "anggar",
                        child: Row(
                          children: const [
                            Icon(Icons.sports_hockey),
                            SizedBox(
                              width: 16,
                            ),
                            Text("Anggar"),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "basket",
                        child: Row(
                          children: const [
                            Icon(Icons.sports_basketball),
                            SizedBox(
                              width: 16,
                            ),
                            Text("Basket"),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "volley",
                        child: Row(
                          children: const [
                            Icon(Icons.sports_volleyball),
                            SizedBox(
                              width: 16,
                            ),
                            Text("Volley"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(onPressed: Save, icon: const Icon(Icons.check))
                ],
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                  width: 128,
                  height: 128,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: (fileImage != null)
                      ? Image.file(fileImage!.file)
                      : CachedNetworkImage(
                          imageUrl: tempUserData.avatar,
                          errorWidget: (context, url, error) {
                            return const Image(
                                image: AssetImage('assets/avatar.png'));
                          },
                          progressIndicatorBuilder: (context, url, progress) {
                            return const CircularProgressIndicator();
                          },
                        )),
              GestureDetector(
                onTap: pickImage,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                  child: Center(
                    child: updatingImage
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Change profile photo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF397CD2),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                child: DropdownButton<String>(
                  value: _controllerJob,
                  elevation: 16,
                  style: const TextStyle(
                      color: Color(0xFF303030),
                      fontWeight: FontWeight.bold,
                    ),
                  onChanged: (String? value) {
                    setState(() {
                      _controllerJob = value!;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  itemHeight: 64,
                  items: [
                    DropdownMenuItem<String>(
                      value: "member",
                      child: Row(
                        children: const [
                          Icon(Icons.person),
                          SizedBox(
                            width: 16,
                          ),
                          Text("Member"),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: "athlete",
                      child: Row(
                        children: const [
                          Icon(Icons.sports_baseball),
                          SizedBox(
                            width: 16,
                          ),
                          Text("Athlete"),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: "coach",
                      child: Row(
                        children: const [
                          Icon(Icons.sports),
                          SizedBox(
                            width: 16,
                          ),
                          Text("Coach"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: _controllerUsername,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Type your username',
                            enabledBorder: enabeledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: errorBorder,
                            focusedErrorBorder: focusedErrorBorder,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: _controllerDescription,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Type a short description',
                            enabledBorder: enabeledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: errorBorder,
                            focusedErrorBorder: focusedErrorBorder,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: TextFormField(
                          controller: _controllerAbout,
                          autofocus: true,
                          obscureText: false,
                          maxLines: 7,
                          decoration: InputDecoration(
                            labelText: 'About',
                            hintText: 'About yourself',
                            enabledBorder: enabeledBorder,
                            focusedBorder: focusedBorder,
                            errorBorder: errorBorder,
                            focusedErrorBorder: focusedErrorBorder,
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
