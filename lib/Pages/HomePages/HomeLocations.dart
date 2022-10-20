import 'package:flutter/material.dart';
import 'package:sports/Pages/api/contents-api.dart';

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
          future: FireDatabase.getLocations(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<LocationData>? locationList = snapshot.data;
                  return ListView.builder(
                    clipBehavior: Clip.hardEdge,
                    itemCount: locationList?.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return LocationCard(locationList![index]);
                    }
                  );
                  } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            )
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
                  fontSize: 12,
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
                        fontSize: 8,
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
                        fontSize: 8,
                      ),
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

class LocationData {
  String title = "";
  String address = "";
  String phone = "";

  LocationData(this.title, this.address, this.phone);

  LocationData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("title")) title = json['title'];
    if (json.containsKey("address")) address = json['address'];
    if (json.containsKey("phone")) phone = json['phone'];
  }

  Map<String, String> toJson() => {
        'title': title,
        'address': title,
        'phone': phone,
      };
}
