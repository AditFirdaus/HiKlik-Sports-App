import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchivementView extends StatefulWidget {
  const AchivementView({super.key});

  @override
  State<AchivementView> createState() => _AchivementViewState();
}

class _AchivementViewState extends State<AchivementView> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                height: 2,
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              children: [
                AchivementViewItem(
                  AchivementData("[ title ]", "[ description ]")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AchivementData {
  String title = "";
  String description = "";

  AchivementData(this.title, this.description);
}

class AchivementViewItem extends StatefulWidget {
  final AchivementData _achivementData;

  const AchivementViewItem(this._achivementData, {super.key});

  @override
  State<AchivementViewItem> createState() => _AchivementViewItemState();
}

class _AchivementViewItemState extends State<AchivementViewItem> {
  
  void Update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ExpansionTile(
        textColor: Colors.grey,
        iconColor: Colors.grey,
        title: Text(
          widget._achivementData.title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              widget._achivementData.description,
            ),
          )
        ],
      ),
    );
  }
}