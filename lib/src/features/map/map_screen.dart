import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/map/widgets/locations_list.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) {
              
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
                    foregroundColor: CoffeeAppColors.primaryTextColor
                  ),
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
