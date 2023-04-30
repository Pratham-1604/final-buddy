// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:chatapp/helpers/location_helper.dart';
import 'package:chatapp/pages/maps_screen.dart';

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

  TextEditingController timeinput = TextEditingController();

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
        GoogleMapsPlaces(apiKey: "AIzaSyDYKrqo4uZx9j0S9D0PeH8fBxarOTswUNg");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 600,
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
                      types: ["locality"],

                      strictbounds: false,
                      components: [Component(Component.country, 'in')],
                      context: context,
                      apiKey: "AIzaSyApTeK_vLWhx6pEKKDSBuYfFknUc4NU8T4",
                      mode: Mode.overlay,
                      // display over the current view
                      language: "en",
                      // components: [Component(Component.country, "in")],
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
                  controller: timeinput,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.timer), //icon of text field
                      labelText: "Enter Time" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context,
                    );

                    if (pickedTime != null) {
                      String formattedTime = "${(pickedTime.hour % 12)}:${pickedTime.minute} ${pickedTime.period.name == DayPeriod.am.name ? "A.M." : "P.M."}"; //output 10:51 PM
                      print(formattedTime);
                      // print(pickedTime.format(context)); //output 10:51 PM
                      // DateTime parsedTime = DateFormat.jm()
                      //     .parse(pickedTime.format(context).toString());
                      // //converting to DateTime so that we can further format on different pattern.
                      // print(parsedTime); //output 1970-01-01 22:53:00.000
                      // String formattedTime =
                      //     DateFormat('HH:mm:ss').format(parsedTime);
                      // print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        timeinput.text =
                            formattedTime; //set the value of text field.
                      });
                    } else {
                      print("Time is not selected");
                    }
                  },
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Next ->'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(MapScreen.routeName);
                    },
                  ),
                ),
                Container(
                  width: 300,
                  height: 400,
                  child: Image.network(
                    LocationHelper.generateLocationPreviewImage(
                      lattitude: lati,
                      longitude: longi,
                    ),
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
