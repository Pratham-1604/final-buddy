// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:chatapp/screens/available_rides.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AskDestination extends StatefulWidget {
  static const routeName = '/askDestination';

  @override
  State<AskDestination> createState() => _AskDestinationState();
}

class _AskDestinationState extends State<AskDestination> {
  var lati = 0.0;
  var longi = 0.0;

  Future<LatLng> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lati = position.latitude;
      longi = position.longitude;
    });
    print('${lati} ${longi}');
    return LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final destinationEditingController = TextEditingController();
    final timeEditingController = TextEditingController();
    GoogleMapsPlaces _places =
        GoogleMapsPlaces(apiKey: "AIzaSyApTeK_vLWhx6pEKKDSBuYfFknUc4NU8T4");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 650,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: destinationEditingController,
                  decoration: InputDecoration(
                    labelText: 'Input destination',
                  ),
                  onTap: () async {
                    // show Google Places autocomplete to get user input
                    Prediction? prediction = await PlacesAutocomplete.show(
                      context: context,
                      apiKey: "AIzaSyApTeK_vLWhx6pEKKDSBuYfFknUc4NU8T4",
                      mode: Mode.overlay, // display over the current view
                      language: "en",
                      components: [Component(Component.country, "in")],
                    );
                    print("prediction: $prediction");
                    if (prediction != null) {
                      // update the text field with the selected place
                      destinationEditingController.text =
                          prediction.description!;
                    }
                  },
                  onSubmitted: (value) async {
                    // convert user input to location coordinates using Google Places API
                    PlacesDetailsResponse details =
                        await _places.getDetailsByPlaceId(value);

                    setState(() {
                      // update the map view with the selected location
                      longi = details.result.geometry!.location.lng;
                      lati = details.result.geometry!.location.lat;
                    });
                  },
                ),
                TextField(
                  controller: timeEditingController,
                  decoration: InputDecoration(
                    labelText: 'Input Time',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      longi = double.parse(value);
                    });
                  },
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Next ->'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AvailableRides.routeName);
                    },
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  child: Image.network(
                    LocationHelper.generateLocationPreviewImage(
                      lattitude: lati,
                      longitude: longi,
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Go to Community tab ->'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
