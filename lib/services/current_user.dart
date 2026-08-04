import 'package:firebase_auth/firebase_auth.dart';

String currentUserId() =>
    FirebaseAuth.instance.currentUser?.uid ?? 'unknown-user';

String currentUserName() =>
    FirebaseAuth.instance.currentUser?.displayName ??
    FirebaseAuth.instance.currentUser?.email ??
    'MeetEm user';
