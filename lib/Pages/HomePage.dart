import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/HomePages/HomeMembers.dart';
import 'package:sports/Pages/HomePages/HomeEvents.dart';
import 'package:sports/Pages/HomePages/HomeLocations.dart';
import 'package:sports/Pages/HomePages/HomeNews.dart';
import 'package:sports/Pages/ProfilePage.dart';
import 'package:sports/Pages/api/contents-api.dart';
import 'package:sports/Pages/user-api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _selectedIndex = 0;
  static int _selectedCategory = 0;
  static String get _currentCategory => _categoryOptions[_selectedCategory];
  static List<String> _categoryOptions = <String>["Anggar", "Basket", "Volley"];

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeNews(),
    const HomeEvents(),
    const HomeMembers(),
    const HomeLocations(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void ToProfile() {
    Navigator.of(context).push(PageTransition(
      type: PageTransitionType.rightToLeftJoined,
      curve: Curves.easeInOutQuart,
      childCurrent: widget,
      child: ProfilePage(FireUser.currentUserData),
      duration: const Duration(milliseconds: 500),
    ));
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
                  GestureDetector(
                    onTap: ToProfile,
                    child: Container(
                      height: 128,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/hiklik-sports-76bdd.appspot.com/o/107502-Anna%20KUN.jpg?alt=media&token=14bb4aa8-b062-47d0-83ed-14ef3a1f94cd',
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  PopupMenuButton(
                      icon: const Icon(Icons.category),
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
                          _buildPopupMenuItem('Anggar', Icons.sports_hockey),
                          _buildPopupMenuItem(
                              'Basket', Icons.sports_basketball),
                          _buildPopupMenuItem(
                              'Volley', Icons.sports_volleyball),
                        ];
                      },
                      onSelected: (value) {
                        setState(() {
                          category = _categoryOptions[value];
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            ModalRoute.withName('/'),
                          );
                        });
                      }),
                ],
              ),
            ),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(32),
            height: 96,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(48)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 0, blurRadius: 8),
              ],
              color: Color(0xFF2D3436),
            ),
            clipBehavior: Clip.hardEdge,
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'News',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Events',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_search),
                  label: 'Athletes',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: 'Locations',
                  backgroundColor: Colors.transparent,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              onTap: _onItemTapped,
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

PopupMenuItem _buildPopupMenuItem(String title, IconData iconData) {
  return PopupMenuItem(
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
