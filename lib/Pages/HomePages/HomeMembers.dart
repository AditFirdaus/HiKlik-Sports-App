import 'package:flutter/material.dart';
import 'package:sports/Pages/Classes/UserData.dart';
import 'package:sports/Pages/api/contents-api.dart';

class HomeMembers extends StatefulWidget {

  const HomeMembers({super.key});

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
          future: FireDatabase.getMembers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              List<UserData>? datas = snapshot.data;

              return ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return AthleteCard(datas![index]);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }
}

class AthleteCard extends StatelessWidget {
  
  final UserData _userData;

  const AthleteCard(this._userData, {super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Card Widget...
        Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFF5F5F5),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/hiklik-sports-76bdd.appspot.com/o/107502-Anna%20KUN.jpg?alt=media&token=14bb4aa8-b062-47d0-83ed-14ef3a1f94cd',
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
                    Text(
                      _userData.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        height: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
