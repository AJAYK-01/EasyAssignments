// import 'package:firebase_messaging/firebase_messaging.dart';

// class Notifications {

//   Notifications._();

//   factory Notifications() => _instance;

//   static final Notifications _instance = Notifications._();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   bool _initialized = false;

//   Future<void> init() async {
//     if (!_initialized) {
//       // For iOS request permission first.
//       _firebaseMessaging.requestNotificationPermissions();
//       _firebaseMessaging.configure();

//       // For testing purposes print the Firebase Messaging token
//       String token = await _firebaseMessaging.getToken();
//       print("FirebaseMessaging token: $token");
      
//       _initialized = true;
//     }
//   }
// }
