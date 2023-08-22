import 'dart:io';
import 'package:drivers_app/authentication/car_info_screen.dart';
import 'package:drivers_app/authentication/phone_signin.dart';
import 'package:drivers_app/mainScreens/new_trip_screen.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'InfoHandler/app_info.dart';
import 'authentication/delete_account.dart';
import 'authentication/login_screen.dart';
import 'authentication/register_screen.dart';
import 'authentication/upload_image.dart';
import 'mainScreens/main_screen.dart';



void main() async{
 


  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

    
  
  runApp(ChangeNotifierProvider(
    create: (context) => AppInfo(),
    child: GetMaterialApp(
        initialRoute: '/',
        routes: {
          '/' : (context) => MySplashScreen(),
          '/main_screen': (context) => MainScreen(),
          '/phone_signin': (context) => Phonesignin(),
          '/delete_account': (context) =>AccountDeletionScreen(),
          '/upload_image': (context) =>ImageUploadScreen(),
          '/login_screen' : (context) => Login(),
          '/register_screen': (context) => Register(),
          '/car_info_screen': (context) => CarInfoScreen(),
          '/new_trip_screen': (context) => NewTripScreen(),
        },
        //home: Home(),
        debugShowCheckedModeBanner: false
    ),
  ));
}







