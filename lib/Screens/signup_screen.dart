import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {


   SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

List<String> list = ["Male", "Female"];
List<String> list2 = ["Matric", "Intermediate", "Bachelors", "Masters", "MPhil/PHD"];
class _SignupScreenState extends State<SignupScreen> {
/*
  creating Objects for class SignupScreen
  */
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController educationController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  bool showPassword = false;

  String dropdownValue = list.first;
  String dropdownValue2 = list2.first;

  GlobalKey<FormState> formkey = GlobalKey();



  @override
  Widget build(BuildContext context) {

    var widthscreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GetBuilder<SignupScreenController>(
          init: SignupScreenController(),
          builder: (logic) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    width: widthscreen,
                    height: heightScreen,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Welcome To create user detail"),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please Enter Data";
                              }
                              else if(value.length <= 2 || value.length >=10)
                                {
                                  return "Please enter Name between 2 to 10 characters";
                                }
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                label: Text("User Name"))),
                        TextFormField(
                          validator: (value) => logic.validateName(value),
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Email")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            } else if (logic.validatePassword(
                                passwordController.text)) {
                              return "Example@1234";
                            }
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Password")),
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100));
                            if(pickedDate != null)
                            {
                              String formattedDate = DateFormat("yyyy-MM-dd").format(pickedDate);
                              dobController.text = formattedDate;

                            }
                            else{
                              Get.snackbar("DateTime", "Date is not selected");
                            }
                          },
                          controller: dobController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Date of Birth")),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Select Gender"),
                            DropdownButton(

                              items: list.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem(child: Text(value),value: value,);
                              }).toList(),
                              onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                                genderController.text = dropdownValue;
                              });
                            },
                              value: dropdownValue,

                            ),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Select Education"),
                            DropdownButton(

                              items: list2.map<DropdownMenuItem<String>>((String value2) {
                                return DropdownMenuItem(child: Text(value2),value: value2,);
                              }).toList(),
                              onChanged: (value2) {
                                setState(() {
                                  dropdownValue2 = value2!;
                                  educationController.text = dropdownValue2;
                                });
                              },
                              value: dropdownValue2,
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: genderController,
                          decoration: InputDecoration(label: Text("Education")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                            else if (logic.validatePhoneNumber(phoneNumberController.text))
                              {
                                return "Pattern Ex 03001111111 or +923001111111";
                              }
                          },
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("phoneNumber")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                          },
                          controller: addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Address")),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                logic.OnSignUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    dobController.text,
                                    genderController.text,
                                    educationController.text,
                                    phoneNumberController.text,
                                    addressController.text,
                                    context);
                              }
                            },
                            child: Text("Register Data"))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
