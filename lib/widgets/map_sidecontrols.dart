import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSideControls extends StatelessWidget {
  final bool is3D;
  final MapType mapType;
  final VoidCallback onToggle3D;
  final VoidCallback onCycleMapType;
  final VoidCallback onRecenter;

  const MapSideControls({
    super.key,
    required this.is3D,
    required this.mapType,
    required this.onToggle3D,
    required this.onCycleMapType,
    required this.onRecenter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ControlButton(
          label: '3D',
          selected: is3D,
          onTap: onToggle3D,
        ),
        const SizedBox(height: 10),
        _ControlButton(
          icon: Icons.layers_outlined,
          onTap: onCycleMapType,
        ),
        const SizedBox(height: 10),
        _ControlButton(
          icon: Icons.navigation_outlined,
          onTap: onRecenter,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  const _ControlButton({this.label, this.icon, this.selected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: selected ? theme.colorScheme.primary : theme.colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: label != null
                ? Text(
                    label!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  )
                : Icon(icon, size: 20, color: theme.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}