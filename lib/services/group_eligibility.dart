// lib/logic/group_eligibility.dart
import '../models/event.dart';

/// Interest threshold from the product brief (section 4.2):
/// UGC events need at least this many interested users before a group
/// can be created. Sourced events bypass the threshold entirely.
const int kInterestThreshold = 3;

/// Whether a group can currently be created for [event].
bool canCreateGroup(Event event) {
  if (!event.isUgc) return true; // sourced events always allow group creation
  return event.interestCount >= kInterestThreshold;
}