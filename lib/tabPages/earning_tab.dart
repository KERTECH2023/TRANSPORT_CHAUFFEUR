/*
import 'package:drivers_app/InfoHandler/app_info.dart';
import 'package:drivers_app/assistants/assistant_methods.dart';
import 'package:drivers_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip_history_model.dart';


class EarningsTabPage extends StatefulWidget {
  TripHistoryModel? tripHistoryModel;
   EarningsTabPage({this.tripHistoryModel});



  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}


class _EarningsTabPageState extends State<EarningsTabPage> {


  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Your Earnings",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black
          ),
        ),

        leadingWidth: 50, // Keeps skip button in single line

        leading: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/main_screen");
          },

          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white
          ),

          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.redAccent,
          ),

        ),
      ),

      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.black,

                ),
              ),


              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ],
                  ),
                ),
              ),

            ],
          ),

          // Last Earning Container
          Positioned(
            top: 50,
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.black12,
                    style: BorderStyle.solid
                  )
              ),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),

                    Text(
                      "Last Earning",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 17,
                      )
                    ),

                    const SizedBox(height: 10,),

                    // Text(
                    //     "TD ${Provider.of<AppInfo>(context,listen: false).lastTripHistoryInformationModel!.fareAmount}",
                        
                    //     style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //       fontSize: 50,
                    //     )
                    // ),
                    const SizedBox(height: 10,),

                    const Divider(
                      thickness: 1,
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.car_rental,
                              size: 20,
                            ),

                            const SizedBox(width: 5),

                            // Text(
                            //     Provider.of<AppInfo>(context,listen: false).lastTripDirectionDetailsInformation!.distance_text!,
                            //     style: const TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black,
                            //       fontSize: 17,
                            //     )
                            // ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        Row(
                          children: [
                            const Icon(
                              Icons.punch_clock_rounded,
                              size: 20,
                            ),

                            const SizedBox(width: 5),

                            // Text(
                            //    Provider.of<AppInfo>(context,listen: false).lastTripDirectionDetailsInformation!.duration_text!,
                            //     style: const TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black,
                            //       fontSize: 15,
                            //     )
                            // ),
                          ],
                        )
                      ],

                    )

                  ],
                ),
              ),
            ),
          ),

          // Total Earning Container
          Positioned(
            top: 300,
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: Colors.black12,
                      style: BorderStyle.solid
                  )
              ),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),

                    Text(
                        "Total Earnings",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 17,
                        )
                    ),

                    const SizedBox(height: 10,),

                    // Text(
                    //     "Tk ${driverData.totalEarnings!}",
                    //     style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black,
                    //       fontSize: 50,
                    //     )
                    // ),

                    const SizedBox(height: 10,),

                    const Divider(
                      thickness: 1,
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.car_rental,
                              size: 20,
                            ),

                            const SizedBox(width: 5),

                            Text(
                                Provider.of<AppInfo>(context,listen: false).countTotalTrips.toString() + " rides",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17,
                                )
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.punch_clock_rounded,
                              size: 20,
                            ),

                            SizedBox(width: 5),

                            Text(
                                "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15,
                                )
                            ),
                          ],
                        )
                      ],

                    )

                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 600,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.fromLTRB(50,15,50,15),
              ),

              child: const Text(
                "Return to home",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:drivers_app/InfoHandler/app_info.dart';
import 'package:drivers_app/assistants/assistant_methods.dart';
import 'package:drivers_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip_history_model.dart';



class EarningsTabPage extends StatefulWidget {
  @override
  _EarningsTabPageState createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Your Earnings",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black),
        ),
        leadingWidth: 50,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/main_screen");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.redAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  EarningsCard(
                    title: "Last Earning",
                    amount: "TD 13.3",
                    details: [
                      Detail(icon: Icons.car_rental, text: "11KM"),
                      Detail(icon: Icons.punch_clock_rounded, text: "11min"),
                    ],
                  ),
                  SizedBox(height: 30),
                  EarningsCard(
                    title: "Total Earnings",
                    amount: "TD 127.5",
                    details: [
                      Detail(icon: Icons.car_rental, text: "5"),
                      Detail(icon: Icons.punch_clock_rounded, text: "N/A"),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                    ),
                    child: const Text(
                      "Return to home",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EarningsCard extends StatelessWidget {
  final String title;
  final String amount;
  final List<Detail> details;

  EarningsCard({required this.title, required this.amount, required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.black12,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: details.map((detail) => Row(
                children: [
                  Icon(
                    detail.icon,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    detail.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Detail {
  final IconData icon;
  final String text;

  Detail({required this.icon, required this.text});
}
