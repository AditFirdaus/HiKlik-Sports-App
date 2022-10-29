import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/api/contents-api.dart';

class HomeMembers extends StatefulWidget {
  const HomeMembers({super.key});

  static Color getColor(String value) {
    Color color = Colors.black;
    switch (value) {
      case "member":
        color = Colors.black;
        break;
      case "athlete":
        color = Colors.green;
        break;
      case "coach":
        color = Colors.yellow;
        break;
      default:
    }
    return color;
  }

  static IconData getIcon(String value) {
    IconData icon = Icons.person;
    switch (value) {
      case "member":
        icon = Icons.person;
        break;
      case "athlete":
        icon = Icons.sports_baseball;
        break;
      case "coach":
        icon = Icons.sports;
        break;
      default:
    }
    return icon;
  }
  
  static String getJob(String value) {
    String job = "";
    switch (value) {
      case "member":
        job = "Member";
        break;
      case "athlete":
        job = "Athlete";
        break;
      case "coach":
        job = "Coach";
        break;
      default:
    }
    return job;
  }

  @override
  State<HomeMembers> createState() => _HomeMembersState();
}

class _HomeMembersState extends State<HomeMembers> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0),
        child: ListView(clipBehavior: Clip.none, children: [
          const Text(
            "Our members!",
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
            future: FireDatabase.getMembers(category: HomePage.categoryType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<UserData>? cachedMember = snapshot.data;
                return ListView.builder(
                    clipBehavior: Clip.hardEdge,
                    itemCount: cachedMember!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return MemberCard(cachedMember[index]);
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ]
      )
    );
  }
}

class MemberCard extends StatelessWidget {
  final UserData _userData;

  const MemberCard(this._userData, {super.key});

  

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFF5F5F5),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          AwesomeDialog(
            context: context,
            animType: AnimType.bottomSlide,
            dialogType: DialogType.info,
            body: MemberDialog(_userData),
            customHeader: Container(
              height: 128,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: _userData.avatar,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return const Image(image: AssetImage('assets/avatar.png'));
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ).show();
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 64,
                height: 64,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: _userData.avatar,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return const Image(image: AssetImage('assets/avatar.png'));
                  },
                  progressIndicatorBuilder: (context, url, progress) {
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _userData.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (_userData.job != "") Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            HomeMembers.getIcon(_userData.job),
                            size: 16,
                            color: HomeMembers.getColor(_userData.job),
                          ),
                          SizedBox(width: 4,),
                          Text(
                            HomeMembers.getJob(_userData.job),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: HomeMembers.getColor(_userData.job),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Text(
                        _userData.description,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
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

class MemberDialog extends StatelessWidget {
  UserData _userData;

  MemberDialog(this._userData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
        bottom: 32.0,
        right: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          if (_userData.job != "") Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                HomeMembers.getIcon(_userData.job),
                size: 16,
                color: HomeMembers.getColor(_userData.job),
              ),
              SizedBox(width: 4,),
              Text(
                HomeMembers.getJob(_userData.job),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: HomeMembers.getColor(_userData.job),
                ),
              ),
            ],
          ),
          Text(
            _userData.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_userData.description),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "About",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_userData.about),
        ],
      ),
    );
  }
}
