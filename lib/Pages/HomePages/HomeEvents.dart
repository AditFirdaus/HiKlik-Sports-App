import 'package:flutter/material.dart';
import 'package:sports/Pages/api/contents-api.dart';

class HomeEvents extends StatefulWidget {
  const HomeEvents({super.key});

  @override
  State<HomeEvents> createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: ListView(clipBehavior: Clip.none, children: [
        const Text(
          "See our Events!",
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
          future: FireDatabase.getEvents(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<EventData>? eventList = snapshot.data;

              return ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  itemCount: snapshot.data?.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return EventCard(eventList![index]);
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ]),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventData _eventData;

  const EventCard(this._eventData, {Key? key}) : super(key: key);

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
        padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _eventData.date,
              style: const TextStyle(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
              child: Text(
                _eventData.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _eventData.address,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Icon(
                      Icons.phone_iphone,
                      color: Colors.black,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _eventData.phone,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventData {
  String title = "";
  String address = "";
  String phone = "";
  String date = "";

  EventData(this.title, this.address, this.phone);

  EventData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("title")) title = json['title'];
    if (json.containsKey("address")) address = json['address'];
    if (json.containsKey("phone")) phone = json['phone'];
    if (json.containsKey("date")) date = json['date'];
  }

  Map<String, String> toJson() => {
        'title': title,
        'address': title,
        'phone': phone,
        'date': date,
      };
}
