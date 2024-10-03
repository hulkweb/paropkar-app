import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.ontapSelectLocation,
  }) : super(key: key);
  final double latitude;
  final double longitude;
  final Function(
    LatLng latLong,
  ) ontapSelectLocation;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  @override
  void initState() {
    // TODO: implement initState
    _selectedLocation = LatLng(widget.latitude, widget.longitude);
    super.initState();
  }

  @override
  void dispose() {
    _mapController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Location Marker'),
      // ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude,
                  widget.longitude), // Default to San Francisco's coordinates
              zoom: 12.0,
            ),
            onTap: (LatLng location) {
              _addMarker(location);
            },
            markers: _selectedLocation == null
                ? Set<Marker>()
                : {
                    Marker(
                      markerId: MarkerId("SelectedLocation"),
                      position: _selectedLocation!,
                      infoWindow: InfoWindow(title: "Selected Location"),
                    ),
                  },
          ),
          Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                child: Text('Select Locatiion'),
                onPressed: () {
                  print(_selectedLocation);
                  Navigator.pop(context);
                  print('done');
                  widget.ontapSelectLocation(
                    _selectedLocation!,
                  );
                },
              ))
        ],
      ),
    );
  }

  void _addMarker(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15.0),
      ),
    );
  }
}

// Future<String> getAddress(LatLng latLong) async {
//   String address = '';
//   await placemarkFromCoordinates(latLong.latitude, latLong.longitude)
//       .then((placemarks) {
//     print('getted address');
//     int index = placemarks.length - 1;
//     print(placemarks[index].toString());
//     String street = placemarks[index].street ?? '';
//     String subLocality = placemarks[index].subLocality ?? '';
//     String subAdministrativeArea =
//         placemarks[index].subAdministrativeArea ?? '';
//     String administrativeArea = placemarks[index].administrativeArea ?? '';
//     String postalCode = placemarks[index].postalCode ?? '';
//     print('returning address');
//     address =
//         "$street, $subLocality, $subAdministrativeArea, $administrativeArea, $postalCode";
//   }).onError((error, stackTrace) {
//     print('=================return  no');
//   });
//   print('=================return  no');
//   return address;
// }

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Radius of the earth in kilometers

  // Convert degrees to radians
  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  // Haversine formula
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c; // Distance in kilometers

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

