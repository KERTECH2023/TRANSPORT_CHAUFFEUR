import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:drivers_app/models/ride_request_information.dart';
import 'package:drivers_app/widgets/push_notification_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../global/global.dart';
@pragma('vm:entry-point')
 Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

 
  print("Handling a background message");
  print("message data: "+ message.data["rideRequestId"].toString());
}
class PushNotificationSystem {
  
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async{
    
    print(FirebaseMessaging.instance.getToken().toString());

    
    // Terminated - When the app is completely closed and the app resumes from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage){
      if(remoteMessage!=null){
        // display ride request information
      print(remoteMessage.data.toString());
       // retrieveRideRequestInformation(remoteMessage.data["rideRequestId"],context);
retrieveRideRequestInformation(remoteMessage.data["rideRequestId"],context);
       
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Background - When the app is minimized and the app resumes from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage!=null){
        // display ride request information
        //retrieveRideRequestInformation(remoteMessage.data["rideRequestId"],context);
        retrieveRideRequestInformation(remoteMessage.data["rideRequestId"],context);
      }
    });

    // Foreground - When the app is open and receives a notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      print("testt 3adii");
      print("teeesstt " + remoteMessage!.data.values.toString());
      if(remoteMessage!=null){
       
        // display ride request information
        retrieveRideRequestInformation(remoteMessage.data["rideRequestId"],context);
        //Fluttertoast.showToast(msg: "This is the ride request ID:" + remoteMessage.data["rideRequestId"]);
      }
    });
  }

  Future generateRegistrationToken() async{
    String? registrationToken = await firebaseMessaging.getToken(); // Generate and get registration token

    FirebaseDatabase.instance.ref()  // Saving the registration token
        .child("Drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    firebaseMessaging.subscribeToTopic("allDrivers");
    firebaseMessaging.subscribeToTopic("allUsers");
  }

  retrieveRideRequestInformation(String rideRequestID,BuildContext context){
    print("gggggggggggg"+ rideRequestID.toString());
    FirebaseDatabase.instance.ref()
        .child("AllRideRequests")
        .child(rideRequestID)
        .child("driverId")
        .onValue.listen((snapData)
    { if(snapData.snapshot.value == "waiting" || snapData.snapshot.value == firebaseAuth.currentUser!.uid){

      FirebaseDatabase.instance.ref().child("AllRideRequests").child(rideRequestID).once().then((snapData)

     {  if(snapData.snapshot.value != null){
          DataSnapshot snapshot = snapData.snapshot;
          
        
          
          if(snapshot.exists){


            String? rideRequestID  = snapshot.key;

            double sourceLat = double.parse((snapData.snapshot.value! as Map)["source"]["latitude"].toString());
            double sourceLng = double.parse((snapData.snapshot.value! as Map)["source"]["longitude"].toString());
            String sourceAddress = (snapData.snapshot.value! as Map)["sourceAddress"];

            double destinationLat = double.parse((snapData.snapshot.value! as Map)["destination"]["latitude"].toString());
            double destinationLng = double.parse((snapData.snapshot.value! as Map)["destination"]["longitude"].toString());
            String destinationAddress = (snapData.snapshot.value! as Map)["destinationAddress"];

            String userName = (snapData.snapshot.value! as Map)["userName"];
            String userPhone = (snapData.snapshot.value! as Map)["userPhone"];
            String healthStatus = (snapData.snapshot.value! as Map)["HealthStatus"];
            String? rideRequestId = snapData.snapshot.key;
            RideRequestInformation rideRequestInformation = RideRequestInformation();
            rideRequestInformation.rideRequestId = rideRequestID;
            rideRequestInformation.userName = userName;
            rideRequestInformation.userPhone = userPhone;
            rideRequestInformation.sourceLatLng = LatLng(sourceLat, sourceLng);
            rideRequestInformation.destinationLatLng = LatLng(destinationLat, destinationLng);
            rideRequestInformation.sourceAddress = sourceAddress;
            rideRequestInformation.destinationAddress = destinationAddress;
            rideRequestInformation.rideRequestId= rideRequestId;
            rideRequestInformation.healthStatus= healthStatus;

            print("id ride "+rideRequestInformation.toString() );
            showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialogBox(
                  rideRequestInformation: rideRequestInformation,
              ),
            );

          }

          else{
            Fluttertoast.showToast(msg: "This ride request is invalid!");
          }
     }});
    }
    else {
      Fluttertoast.showToast(msg: "this Ride request  has been cancelled");
      Navigator.pop(context);
    }
    });

  }
}