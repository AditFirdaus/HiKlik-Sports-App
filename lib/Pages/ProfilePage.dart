import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/ProfileEditPage.dart';
import 'package:sports/Pages/SignInPage.dart';
import 'package:sports/Pages/Widgets/AchivementView.dart';
import 'package:sports/Pages/Widgets/GalleryView.dart';

class ProfilePage extends StatefulWidget {
  UserData _userData;

  ProfilePage(this._userData, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void ToHome() {
    Navigator.of(context).pushReplacement(PageTransition(
      type: PageTransitionType.leftToRightJoined,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      child: const HomePage(),
      duration: const Duration(seconds: 1),
    ));
  }

  Future ToProfileEdit() async {
    await Navigator.of(context).push(PageTransition(
      type: PageTransitionType.size,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      alignment: Alignment.topCenter,
      child: const ProfileEditPage(),
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    ));
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(128),
            child: PreferredSize(
              preferredSize: const Size.fromHeight(128),
              child: FloatingAppBar(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: ToHome,
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: ToProfileEdit, icon: const Icon(Icons.edit))
                  ],
                ),
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
                  widget._userData.avatar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      widget._userData.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        height: 2,
                      ),
                    ),
                    Text(
                      widget._userData.description,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0xFFF5F5F5),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 4,
                        ),
                      ),
                      Text(
                        widget._userData.about,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const AchivementView(),
              const GalleryView(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(256, 64),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Log Out"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
