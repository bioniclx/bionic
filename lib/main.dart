import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBKWljBNEi9cR4ZUOlFWskIMTXbxQNkgjY',
      appId: '1:843413523824:android:91b0435c3085a43b77d3b5',
      messagingSenderId: '843413523824',
      projectId: 'bionic-81422',
      storageBucket: 'gs://bionic-81422.appspot.com',
    ),
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
