import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onofflive/components/const_image.dart';
import 'package:onofflive/controller/rgister_controller.dart';
import 'package:onofflive/views/main_screen.dart';

class UsrLoginScreen extends StatelessWidget {
  UsrLoginScreen({super.key});

  RgisterController rgisterController = Get.put(RgisterController());

  final inputDecoration = InputDecoration(
    labelStyle: TextStyle(color: const Color.fromARGB(179, 10, 9, 9)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(137, 29, 23, 23)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    rgisterController.register();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ConstImage.jan),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: size.width,
                height: size.height / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset(ConstImage.logo)],
                    ),
                    SizedBox(height: size.height / 10),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 16),
                      child: Text(
                        'Good to see you again!',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Please enter your username and password",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 141, 137, 127),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextField(
                        controller: rgisterController.userNameEditingController,
                        style: TextStyle(color: Colors.black),

                        decoration: inputDecoration.copyWith(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'User Name',
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextField(
                        controller: rgisterController.passwordEditingController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: inputDecoration.copyWith(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password',
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: size.width / 2.8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        onPressed: () async {
                          if (rgisterController
                                  .userNameEditingController
                                  .text
                                  .isEmpty ||
                              rgisterController
                                  .passwordEditingController
                                  .text
                                  .isEmpty) {
                            Get.rawSnackbar(
                              messageText: const Text(
                                "Please fill in all fields",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              titleText: const Text(
                                "Error",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.grey[900]!,
                              icon: const Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                              ),
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 12,
                              duration: const Duration(seconds: 3),
                              animationDuration: const Duration(
                                milliseconds: 400,
                              ),
                            );
                            return;
                          }

                          bool success = await rgisterController.register();
                          if (!success) {
                            Get.rawSnackbar(
                              messageText: const Text(
                                "Login failed. Please try again.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              titleText: const Text(
                                "Error",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.grey[900]!,
                              icon: const Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                              ),
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 12,
                              duration: const Duration(seconds: 3),
                              animationDuration: const Duration(
                                milliseconds: 400,
                              ),
                            );
                            return;
                          }
                          if (success) {
                            Get.offAll(HomeScreen());
                          }
                        },

                        child: Text('Log In'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
