import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sports/Pages/HomePage.dart';
import 'package:sports/Pages/api/contents-api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeLocations extends StatefulWidget {
  const HomeLocations({super.key});

  @override
  State<HomeLocations> createState() => _HomeLocationsState();
}

class _HomeLocationsState extends State<HomeLocations> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
      child: ListView(clipBehavior: Clip.none, children: [
        const Text(
          "Our Locations near you!",
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
          future: FireDatabase.getLocations(category: HomePage.categoryType),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<LocationData>? cachedLocation = snapshot.data;
              return ListView.builder(
                clipBehavior: Clip.hardEdge,
                itemCount: cachedLocation!.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return LocationCard(cachedLocation[index]);
                }
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ]
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final LocationData _locationData;

  const LocationCard(this._locationData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFFF5F5F5),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Slidable(
        key: const ValueKey(0),

        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                launchUrlString(_locationData.link, mode: LaunchMode.externalApplication);
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.directions,
              label: 'Direction',
            ),
            SlidableAction(
              onPressed: (context) {
                launchUrlString("tel:${_locationData.phone}");
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.call,
              label: 'Call',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                child: Text(
                  _locationData.title,
                  style: const TextStyle(
                    color: Color(0xFF2D3436),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                      child: Icon(
                        Icons.location_pin,
                        color: Color(0xFF2D3436),
                        size: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _locationData.address,
                        style: const TextStyle(
                          color: Color(0xFF2D3436),
                          fontSize: 16,
                        ),
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
                        color: Color(0xFF2D3436),
                        size: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _locationData.phone,
                        style: const TextStyle(
                          color: Color(0xFF2D3436),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Expanded(
                      child: Text(
                        "Slide to expand",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(0xFF2D3436),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                      child: Icon(
                        Icons.swipe_left,
                        color: Color(0xFF2D3436),
                        size: 16,
                      ),
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

class LocationData {
  String title = "";
  String address = "";
  String phone = "";
  String link = "";

  LocationData(this.title, this.address, this.phone);

  LocationData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("title")) title = json['title'];
    if (json.containsKey("address")) address = json['address'];
    if (json.containsKey("phone")) phone = json['phone'];
    if (json.containsKey("link")) link = json['link'];
  }

  Map<String, String> toJson() => {
        'title': title,
        'address': address,
        'phone': phone,
        'link': link,
      };
}
