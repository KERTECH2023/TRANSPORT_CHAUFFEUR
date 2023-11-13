import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController cStatusController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController cnicNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;
  DateTime? selectedDate;
   bool cStatus = false; 
  String? selectedGender;

  List<String> genderOptions = ["Homme", "Femme"];

  @override
  void initState() {
    super.initState();
    nameTextEditingController.addListener(() => setState(() {}));
    emailTextEditingController.addListener(() => setState(() {}));
    phoneTextEditingController.addListener(() => setState(() {}));
    dateNaissanceController.addListener(() => setState(() {}));
    genderController.addListener(() => setState(() {}));
    cStatusController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
    postalCodeController.addListener(() => setState(() {}));
    licenceController.addListener(() => setState(() {}));
    cnicNoController.addListener(() => setState(() {}));
  }

  saveUserInfo() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Processing, Please wait");
        });

    final User? firebaseUser = (await firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((message) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error" + message.toString());
        }))
        .user;

    if (firebaseUser != null) {
      Map userMap = {
        'id': firebaseUser.uid,
        'name': nameTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
        'phone': phoneTextEditingController.text.trim(),
        'DateNaissance': dateNaissanceController.text.trim(),
        'gender': selectedGender,
        'Cstatus': false,
        'address': addressController.text.trim(),
        'postalCode': postalCodeController.text.trim(),
        'licence': licenceController.text.trim(),
        'cnicNo': cnicNoController.text.trim(),
      };

      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child('Drivers');
      databaseReference.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.pushNamed(context, '/car_info_screen');
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateNaissanceController.text =
            "${selectedDate!.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Image.asset("images/logofi.png"),
                  const Text(
                    "Register as a Driver",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: nameTextEditingController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: nameTextEditingController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  nameTextEditingController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else
                        return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                      suffixIcon:
                          emailTextEditingController.text.isEmpty
                              ? Container(width: 0)
                              : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () =>
                                      emailTextEditingController.clear(),
                                ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else if (!value.contains('@')) {
                        return "Invalid Email Address";
                      } else
                        return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Phone Number",
                      prefixIcon: Icon(Icons.phone),
                      suffixIcon: phoneTextEditingController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  phoneTextEditingController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else if (value.length != 12) {
                        return "Enter Correct Number";
                      } else
                        return null;
                    },
                  ),

                 

                  // const SizedBox(height: 20),

                  // TextFormField(
                  //   controller: cStatusController,
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //   ),
                  //   decoration: InputDecoration(
                  //     labelText: "Cstatus",
                  //     hintText: "Cstatus",
                  //   prefixIcon: Icon(Icons.topic),
                  //     suffixIcon: cStatusController.text.isEmpty
                  //         ? Container(width: 0)
                  //         : IconButton(
                  //             icon: Icon(Icons.close),
                  //             onPressed: () =>
                  //                 cStatusController.clear(),
                  //           ),
                  //     enabledBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black),
                  //     ),
                  //     focusedBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.black),
                  //     ),
                  //     hintStyle: const TextStyle(
                  //         color: Colors.grey, fontSize: 15),
                  //     labelStyle: const TextStyle(
                  //         color: Colors.black, fontSize: 15),
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "The field is empty";
                  //     } else if (value.length != 5) {
                  //       return "Invalid number";
                  //     } else
                  //       return null;
                  //   },
                  // ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: addressController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Address",
                      hintText: "Address",
                    prefixIcon: Icon(Icons.streetview),
                      suffixIcon: addressController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  addressController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else
                        return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: postalCodeController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Postal Code",
                      hintText: "Postal Code",
                    prefixIcon: Icon(Icons.post_add),
                      suffixIcon: postalCodeController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  postalCodeController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else
                        return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: licenceController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Licence",
                      hintText: "Licence",
                  prefixIcon: Icon(Icons.numbers),
                      suffixIcon: licenceController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  licenceController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else if (value.length != 5) {
                        return "Enter Correct Number";
                      } else
                        return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: cnicNoController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "CNIC Number",
                      hintText: "CNIC Number",
                   prefixIcon: Icon(Icons.label_important_outline),
                      suffixIcon: cnicNoController.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  cnicNoController.clear(),
                            ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else
                        return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: passwordTextEditingController,
                    keyboardType: TextInputType.text,
                    obscureText: isPasswordVisible,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: isPasswordVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            if (isPasswordVisible == true) {
                              setState(() {
                                isPasswordVisible = false;
                              });
                            } else {
                              setState(() {
                                isPasswordVisible = true;
                              });
                            }
                          }),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontSize: 15),
                      labelStyle: const TextStyle(
                          color: Colors.black, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "The field is empty";
                      } else if (value.length < 6) {
                        return "Password too short";
                      } else
                        return null;
                    },
                  ),
                   const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: selectedDate != null
                              ? "${selectedDate!.toLocal()}"
                                  .split(' ')[0]
                              : "",
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          hintText: "Date of Birth",
                        ),
                        validator: (value) {
                          if (selectedDate == null) {
                            return "Select Date of Birth";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField(
                    value: selectedGender,
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              child: Text(gender),
                              value: gender,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value as String?;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Gender",
                      hintText: "Gender",
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Select Gender";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveUserInfo();
                        }
                        var response = http.post(
                            Uri.parse(
                                "http://192.168.1.2:3000/Chauff/AjoutChauf"),
                            body: {
                              "Nom": nameTextEditingController.value.toString(),
                              "Prenom":
                                  passwordTextEditingController.value.toString(),
                              "phone":
                                  phoneTextEditingController.value.toString(),
                              "email":
                                  emailTextEditingController.value.toString(),
                              "DateNaissance":
                                  dateNaissanceController.value.toString(),
                              "gender": selectedGender!,
                              "Cstatus": cStatus.toString(),
                              "address": addressController.value.toString(),
                              "postalCode":
                                  postalCodeController.value.toString(),
                              "licence": licenceController.value.toString(),
                              "cnicNo": cnicNoController.value.toString(),
                            });
                        print(response.toString());
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),

                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_screen');
                      },
                      child: const Text(
                        "Already have an account? Login Now",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
