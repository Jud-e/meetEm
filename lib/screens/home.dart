import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/mock_events.dart';
import '../../models/event.dart';
import '../widgets/event_preview_sheet.dart';
import '../widgets/map_bottom_sheet.dart';
import '../widgets/map_side_controls.dart';

class MapScreen extends StatefulWidget {
  final void Function(Event event) onViewEventDetails;
  final VoidCallback onOpenProfile;

  const MapScreen({super.key, required this.onViewEventDetails, required this.onOpenProfile});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Centered on Metro Vancouver, per the brief's target market.
  static const _initialPosition = CameraPosition(target: LatLng(49.2400, -123.0000), zoom: 10.5);
  static const _mapTypeCycle = [MapType.normal, MapType.satellite, MapType.terrain, MapType.hybrid];

  GoogleMapController? _controller;
  bool _is3D = false;
  MapType _mapType = MapType.normal;

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

  void _toggle3D() {
    setState(() => _is3D = !_is3D);
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _initialPosition.target,
        zoom: _initialPosition.zoom,
        tilt: _is3D ? 60 : 0,
      ),
    ));
  }

  void _cycleMapType() {
    final next = _mapTypeCycle[(_mapTypeCycle.indexOf(_mapType) + 1) % _mapTypeCycle.length];
    setState(() => _mapType = next);
  }

  void _recenter() {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _buildMarkers(context),
            mapType: _mapType,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _controller = controller,
          ),
          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).size.height * 0.32 + 16,
            child: SafeArea(
              child: MapSideControls(
                is3D: _is3D,
                mapType: _mapType,
                onToggle3D: _toggle3D,
                onCycleMapType: _cycleMapType,
                onRecenter: _recenter,
              ),
            ),
          ),
          MapBottomSheet(
            suggestedEvents: mockEvents,
            onOpenProfile: widget.onOpenProfile,
            onSelectEvent: (event) => EventPreviewSheet.show(context, event, () => widget.onViewEventDetails(event)),
          ),
        ],
      ),
    );
  }
}