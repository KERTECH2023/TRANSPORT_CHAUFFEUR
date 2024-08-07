import 'package:drivers_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
class FareAmountDialog extends StatefulWidget {

  String? fareAmount;
  String? userName;

  FareAmountDialog({this.fareAmount,this.userName});

  @override
  State<FareAmountDialog> createState() => _FareAmountDialogState();
}

class _FareAmountDialogState extends State<FareAmountDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      backgroundColor: Color.fromRGBO(0 , 177 , 118, 1),
      child: Container(
        margin: EdgeInsets.all(6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0 , 177 , 118, 1),
          borderRadius: BorderRadius.circular(6)
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                AppLocalizations.of(context)!.tripFareAmount,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Ask ${widget.userName!} to pay",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),

              const SizedBox(height: 10),

              Text(
                widget.fareAmount.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 40),

              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.white,
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, "/main_screen");
                    driverIsOnlineNow();
                  },

                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent
                  ),

                  child:  Text(
                   // AppLocalizations.of(context)!.signout,
                    "cash paid",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              )

            ],
          ),
        ),

      ),
    );
  }

    driverIsOnlineNow() async{
    driverCurrentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Geofire.initialize("ActiveDrivers"); // Setting up a new node in realtime database
    Geofire.setLocation(currentFirebaseUser!.uid, driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);

    DatabaseReference reference = FirebaseDatabase.instance.ref()
        .child("Drivers").child(currentFirebaseUser!.uid).child("newRideStatus");

    reference.set("Idle");
    reference.onValue.listen((event) { });


  }

}
