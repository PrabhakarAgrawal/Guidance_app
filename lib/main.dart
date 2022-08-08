import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newapp/providers/providerUser.dart';
import 'package:newapp/responsive/mobilescreen_layout.dart';
import 'package:newapp/responsive/web_screen_layout.dart';
import 'package:newapp/ui/aspirant_guide_selection.dart';
import 'package:newapp/ui/loginpage.dart';
import 'package:newapp/ui/signuppage.dart';
import 'package:newapp/responsive/responsive_layout_screen.dart.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyB8l7MZCrYxNwhJgINSCHZ3JbKdKZ2jcw0',
      appId: '1:551995240894:web:09d812dfd658eb7b95c9ef',
      messagingSenderId: '551995240894',
      projectId: 'newapp-c001b',
      storageBucket: 'newapp-c001b.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return MobileScreenLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return loginscreen();
          })));
  // persisted user
}
