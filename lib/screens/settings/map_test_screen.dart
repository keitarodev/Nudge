import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapTestScreen extends StatefulWidget {
  const MapTestScreen({super.key});

  @override
  State<MapTestScreen> createState() => _MapTestScreenState();
}

class _MapTestScreenState extends State<MapTestScreen> {
  LatLng? selectedLocation;
  double radius = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Location")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(11.5564, 104.9282),
                initialZoom: 13,
                onTap: (tapPosition, point) {
                  setState(() {
                    selectedLocation = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.nudge',
                ),
                if (selectedLocation != null)
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: selectedLocation!,
                        radius: radius,
                        useRadiusInMeter: true,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15),
                        borderColor: Theme.of(context).colorScheme.primary,
                        borderStrokeWidth: 2,
                      ),
                    ],
                  ),
                if (selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: selectedLocation!,
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Radius: ${radius.toInt()}m",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Slider(
                  min: 100,
                  max: 1000,
                  divisions: 9,
                  value: radius,
                  onChanged: (value) {
                    setState(() {
                      radius = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
