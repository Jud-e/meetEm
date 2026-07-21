import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/mock_events.dart';
import '../../models/event.dart';
import '../../widgets/event_preview_sheet.dart';

class MapScreen extends StatefulWidget {
  final void Function(Event event) onViewEventDetails;

  const MapScreen({super.key, required this.onViewEventDetails});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Centered on Metro Vancouver, per the brief's target market.
  static const _initialPosition = CameraPosition(target: LatLng(49.2400, -123.0000), zoom: 10.5);

  GoogleMapController? _controller;

  Set<Marker> _buildMarkers(BuildContext context) {
    final theme = Theme.of(context);
    final hue = theme.brightness == Brightness.dark ? BitmapDescriptor.hueCyan : BitmapDescriptor.hueAzure;

    return mockEvents.map((event) {
      return Marker(
        markerId: MarkerId(event.id),
        position: LatLng(event.lat, event.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          event.isUgc ? BitmapDescriptor.hueOrange : hue,
        ),
        onTap: () => EventPreviewSheet.show(context, event, () => widget.onViewEventDetails(event)),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _buildMarkers(context),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _controller = controller,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: _SearchBar(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder search/filter bar — not wired up in the prototype yet.
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
          const SizedBox(width: 10),
          Text('Search events near you', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}