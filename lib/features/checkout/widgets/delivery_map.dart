import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:produit_maillot_pro/shared/theme/app_theme.dart';

class DeliveryMap extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const DeliveryMap({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  static const LatLng _center = LatLng(14.7167, -17.4677); // Dakar, Senegal
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
          onTap: (location) {
            setState(() {
              _selectedLocation = location;
            });
            widget.onLocationSelected(location);
          },
          markers: _selectedLocation == null
              ? {}
              : {
                  Marker(
                    markerId: const MarkerId('selected'),
                    position: _selectedLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                  ),
                },
          myLocationEnabled: true,
          style: AppTheme.mapStyle, // This would be a JSON string for dark mode
        ),
      ),
    );
  }
}
