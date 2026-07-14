import '../models/event.dart';

final mockEvents = <Event>[
  Event(
    id: 'e1',
    name: 'Sunset Beach Volleyball',
    time: DateTime.now().add(const Duration(hours: 3)),
    lat: 49.2827,
    lng: -123.1440,
    interestCount: 14,
  ),
  Event(
    id: 'e2',
    name: 'Gastown Night Market',
    time: DateTime.now().add(const Duration(hours: 5)),
    lat: 49.2837,
    lng: -123.1064,
    interestCount: 42,
  ),
  Event(
    id: 'e3',
    name: 'Trivia Night @ The Cambie',
    time: DateTime.now().add(const Duration(days: 1, hours: 1)),
    lat: 49.2807,
    lng: -123.1180,
    interestCount: 8,
  ),
  Event(
    id: 'e4',
    name: 'New West Pier Meetup',
    time: DateTime.now().add(const Duration(hours: 6)),
    lat: 49.2057,
    lng: -122.9110,
    interestCount: 2,
    isUgc: true,
  ),
  Event(
    id: 'e5',
    name: 'Surrey Tech Mixer',
    time: DateTime.now().add(const Duration(days: 2)),
    lat: 49.1913,
    lng: -122.8490,
    interestCount: 27,
  ),
  Event(
    id: 'e6',
    name: 'Douglas College Board Games',
    time: DateTime.now().add(const Duration(days: 1, hours: 4)),
    lat: 49.2038,
    lng: -122.9114,
    interestCount: 5,
    isUgc: true,
  ),
];