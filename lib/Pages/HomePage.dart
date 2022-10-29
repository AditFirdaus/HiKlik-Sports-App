import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sports/Pages/HomePages/HomeMembers.dart';
import 'package:sports/Pages/HomePages/HomeEvents.dart';
import 'package:sports/Pages/HomePages/HomeLocations.dart';
import 'package:sports/Pages/HomePages/HomeNews.dart';
import 'package:sports/Pages/ProfilePage.dart';
import 'package:sports/Pages/user-api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static int selectedIndex = 0;
  static int selectedCategory = 0;

  static final List<String> _categoryOptions = <String>[
    "",
    "anggar",
    "basket",
    "volley"
  ];

  static String get categoryType => _categoryOptions[selectedCategory];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {


    final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }

  void _onItemTapped(int index) {
    setState(() {
      HomePage.selectedIndex = index;
    });
  }

  Future FetchUser() async {
    await FireUser.SyncIn();
    setState(() {
      
    });
  }

  void ToProfile() async {
    await FetchUser();
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.rightToLeftJoined,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      child: ProfilePage(FireUser.currentUserData),
      duration: const Duration(milliseconds: 500),
    ));
  }

  @override
  void initState() {
    FetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: ClipRect(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(128),
              child: FloatingAppBar(
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 64,
                      child: GestureDetector(
                        onTap: ToProfile,
                        child: Container(
                          height: 128,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: FireUser.currentUserData.avatar,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Image(
                                  image: AssetImage('assets/avatar.png'));
                            },
                            progressIndicatorBuilder: (context, url, progress) {
                              return const CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          "assets/header.png"
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 32,
                        ),
                        PopupMenuButton(
                          icon: const Icon(Icons.category),
                          onSelected: (value) {
                            setState(() {
                              HomePage.selectedCategory = value;
                            });
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          itemBuilder: (context) {
                            return [
                              _buildPopupMenuItem('All', 0, Icons.sports),
                              _buildPopupMenuItem('Anggar', 1, Icons.sports_hockey),
                              _buildPopupMenuItem('Basket', 2, Icons.sports_basketball),
                              _buildPopupMenuItem('Volley', 3, Icons.sports_volleyball),
                            ];
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              child: TabBarView(
                children: <Widget>[
                  HomeNews(),
                  HomeEvents(),
                  HomeMembers(),
                  HomeLocations(),
                ],
              ),
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(32),
              height: 96,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(48)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, 
                    spreadRadius: 0, 
                    blurRadius: 8
                  ),
                ],
                color: Color(0xFF2D3436),
              ),
              clipBehavior: Clip.antiAlias,
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.newspaper), text: 'News'),
                    Tab(icon: Icon(Icons.calendar_month), text: 'Events'),
                    Tab(icon: Icon(Icons.card_membership), text: 'Members'),
                    Tab(icon: Icon(Icons.location_on), text: 'Locations'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingAppBar extends StatelessWidget {
  final Widget child;

  const FloatingAppBar(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: child,
    );
  }
}

PopupMenuItem _buildPopupMenuItem(String title, int value, IconData iconData) {
  return PopupMenuItem(
    value: value,
    child: Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(title),
      ],
    ),
  );
}
