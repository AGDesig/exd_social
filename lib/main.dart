import 'package:exd_social/Screens/Shapes/practice_shapes.dart';
import 'package:exd_social/Screens/home_bottom_tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'Screens/login_screen.dart';
getFCMToken() async{
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCMToken $token");
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await getFCMToken();
  runApp(const MyApp());
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message Recieve ${message.data}");
      if(message.notification !=null)
        {
          message.notification!.title;
        }
      print("Message also contained a notification ${message.notification!.toMap()}");
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }


  @override
  Widget build(BuildContext context) {
User? user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(home: user==null? LoginScreen():HomeBottomTabBar());
  }
}

