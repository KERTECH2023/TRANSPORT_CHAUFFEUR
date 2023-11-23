import 'package:drivers_app/InfoHandler/app_info.dart';
import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/splashScreen/splash_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProfileTabPage extends StatefulWidget {
   String? photoUrl; 
   ProfileTabPage({Key? key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            
            Column(
              
              children: [
                const SizedBox(
                        height: 30,
                      ),
                // Container(
                //   height: 90,
                //   decoration: const BoxDecoration(
                //     color: Colors.black,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                            
                          ),
                          
                          child:   FutureBuilder(
                    future: getImageUrl(), // Function to get the image URL
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CircleAvatar(
                          radius: 40,
                           backgroundImage: snapshot.data != null ? NetworkImage(snapshot.data.toString()) : null,
        child: snapshot.data == null
            ? const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              )
            : null,
      );
    } else {
      // Show a loading indicator while waiting for the image URL
      return CircularProgressIndicator();
    }
                    },
                  ),
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          driverData.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            //
                          },
                          child: Text(
                            'Total Trips: ${Provider.of<AppInfo>(context, listen: false).countTotalTrips}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // Name
                      Text(
                         AppLocalizations.of(context)!.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Name - Value
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                driverData.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Email
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Email - value
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                driverData.email!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                         AppLocalizations.of(context)!.phoneNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Number - value
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                driverData.phone!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      //    Text(
                      //   "Day of Birth",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.grey[600]),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Number - value
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           driverData.DateNaissance!,
                      //           style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Icon(Icons.arrow_forward_ios),
                      //   ],
                      // ),
                      //  SizedBox(
                      //   height: 10,
                      // ),
                      // const Divider(
                      //   thickness: 1,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      //   Text(
                      //   "Address",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.grey[600]),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Number - value
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           driverData.address!,
                      //           style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Icon(Icons.arrow_forward_ios),
                      //   ],
                      // ),
                      //  SizedBox(
                      //   height: 10,
                      // ),
                      // const Divider(
                      //   thickness: 1,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      //  Text(
                      //   "CnicNo",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.grey[600]),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // // Number - value
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text(
                      //           driverData.Cstatus!,
                      //           style: const TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Icon(Icons.arrow_forward_ios),
                      //   ],
                      // ),
                      //  SizedBox(
                      //   height: 10,
                      // ),
                      // const Divider(
                      //   thickness: 1,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Password
                      Text(
                         AppLocalizations.of(context)!.password,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Password - value
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                ".......",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Positioned(
            //   top: 0,
              // child: Container(
              //   height: 90,
              //   width: 100,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.grey[200],
              //     border: Border.all(
              //       width: 2,
              //       color: Colors.white,
              //     ),
              //   ),
               
              // ),
            // ),
          ],
        ),
      ),
    );
  }
   Future<String> getImageUrl() async {
    if (driverData.photoUrl != null) {
      // If the photoUrl is already provided, use it directly
      return widget.photoUrl!;
    } else {
      // If not, retrieve the photo URL from Firebase Storage based on user ID
      String userId = firebaseAuth.currentUser?.uid ?? "";
      String path = 'chauffeur_images/${userId}.jpg'; // Adjust the path based on your storage structure
      Reference ref = FirebaseStorage.instance.ref(path);
      return await ref.getDownloadURL();
    }
  }
}
