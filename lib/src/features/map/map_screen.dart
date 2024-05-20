import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/widgets/locations_list.dart';
import 'package:flutter_course/src/features/map/widgets/point_bottom_sheet.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/model/location.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:flutter_course/src/theme/image_sources.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  List<PlacemarkMapObject> _getCoffeeLocations() {
    final List<Location> locations = context.read<MenuBloc>().state.locations!;

    return locations
        .map((obj) => PlacemarkMapObject(
              mapId: MapObjectId("Point ${obj.id}"),
              point: Point(latitude: obj.lat, longitude: obj.lng),
              opacity: 1,
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(ImageSources.mapPoint),
                  scale: 2.0)),
              onTap: (mapObject, point) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  constraints: const BoxConstraints.tightFor(height: 180),
                  builder: (context) => PointBottomSheet(index: obj.id),
                );
              },
            ))
        .toList();
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            mapObjects: _getCoffeeLocations(),
            onMapCreated: (controller) async {
              try {
                final position = await _determinePosition();
                controller
                    .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                        target: Point(
                  latitude: position.latitude,
                  longitude: position.longitude,
                ))));
              } on Exception catch (e) {
                _showSnackBar(e.toString());
                log(e.toString());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: CoffeeAppColors.cardBackground,
                      foregroundColor: CoffeeAppColors.primaryTextColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: CoffeeAppColors.cardBackground,
                    foregroundColor: CoffeeAppColors.primaryTextColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const LocationsList()));
                  },
                  child: const Icon(Icons.map_outlined),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
