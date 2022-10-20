import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/Widgets/AchivementView.dart';
import 'package:sports/Pages/Widgets/GalleryView.dart';
import 'package:sports/Pages/user-api.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  bool updatingImage = false;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();

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
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    super.dispose();
  }

  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    this.image = imageTemp;
  }

  Future<String> uploadImage() async {
    String downloadUrl = "";

    try {
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child('avatars/${FireUser.user?.uid}')
          .putFile(image!);

      downloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      log('Failed to upload image: $e');
    }

    return downloadUrl;
  }

  Future ChangeProfilePicture() async {
    await pickImage();

    setState(() {
      updatingImage = true;
    });

    String url = await uploadImage();

    FireUser.currentUserData.avatar = url;

    FireUser.SyncUp();
    FireUser.SyncIn();

    setState(() {
      updatingImage = false;
    });
  }

  void Save() {}

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
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel)),
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
                child: Image.network(
                  FireUser.currentUserData.avatar,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: ChangeProfilePicture,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                  child:
                  Center(
                    child: updatingImage ?
                    const CircularProgressIndicator() : 
                    const Text(
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
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Type your name',
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
                          controller: textController2,
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
                          controller: textController4,
                          autofocus: true,
                          obscureText: false,
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
