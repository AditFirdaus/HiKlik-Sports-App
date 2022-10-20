import 'package:flutter/material.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/ProfileEditPage.dart';

class MemberPage extends StatelessWidget {
  
  const MemberPage({Key? key}) : super(key: key);

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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileEditPage(),
                        )
                      );
                    }, icon: const Icon(Icons.edit))
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
                  'https://firebasestorage.googleapis.com/v0/b/hiklik-sports-76bdd.appspot.com/o/107502-Anna%20KUN.jpg?alt=media&token=14bb4aa8-b062-47d0-83ed-14ef3a1f94cd',
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                child: Text(
                  '[Athlete Name]',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
                child: Text(
                  '[Athlete Description]',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
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
                    children: const [
                      Text(
                        'About',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '[Athlete About]',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
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
                        'Achivement',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: const [
                          ListTile(
                            title: Text(
                              '[Achivement Title]',
                            ),
                            subtitle: Text(
                              '[Achivement Description]',
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: Color(0xFFF5F5F5),
                            dense: false,
                          ),
                          ListTile(
                            title: Text(
                              '[Achivement Title]',
                            ),
                            subtitle: Text(
                              '[Achivement Description]',
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: Color(0xFFF5F5F5),
                            dense: false,
                          ),
                          ListTile(
                            title: Text(
                              '[Achivement Title]',
                            ),
                            subtitle: Text(
                              '[Achivement Description]',
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: Color(0xFFF5F5F5),
                            dense: false,
                          ),
                          ListTile(
                            title: Text(
                              '[Achivement Title]',
                            ),
                            subtitle: Text(
                              '[Achivement Description]',
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: Color(0xFFF5F5F5),
                            dense: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0xFFF5F5F5),
                child: GridView(
                  primary: false,
                  padding: EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://picsum.photos/seed/242/600',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
