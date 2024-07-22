// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();

  static const LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // San Francisco
  LatLng _lastMapPosition = _initialPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Search'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12.0,
            ),
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.blueAccent),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a location',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8, top: 8),
                      ),
                      onSubmitted: _searchLocation,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.my_location, color: Colors.blueAccent),
                    onPressed: _getCurrentLocation,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(location.latitude, location.longitude),
              zoom: 14.0,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
