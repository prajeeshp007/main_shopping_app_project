import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/controller/registration_screen_controller.dart';
import 'package:main_shopping_app_project/view/sign_in_screen/sign_in_screen.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo : write code  create controllers and form keys
    final _formKey1 = GlobalKey<FormState>();

    TextEditingController email = TextEditingController();

    TextEditingController password = TextEditingController();

    TextEditingController confrmpass = TextEditingController();

    final providerobj = context.watch<RegistrationScreenController>();

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                        'https://randaderkson.com/wp-content/uploads/2020/05/how-to-add-more-veggies-to-your-diet-683x1024.jpg'),
                    Container(
                      child: Text(
                        "Sign Up for Free",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        hintText: "Your Eamil Address",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xff1a75d2),
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.red.shade400,
                            )),
                      ),
                      validator: (value) {
                        if (value != null && value.contains('@')) {
                          return null;
                        } else {
                          return 'please enter a proper email';
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          hintText: "Your Password",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xff1a75d2),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.red.shade400,
                              )),
                          suffixIcon: Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          )),
                      validator: (value) {
                        if (value != null && value.length >= 6) {
                          return null;
                        } else {
                          return 'at least need 8 charactrs in password';
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: confrmpass,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          hintText: "Confirm Your Password",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xff1a75d2),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.red.shade400,
                              )),
                          suffixIcon: Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          )),
                      validator: (value) {
                        if (password.text == confrmpass.text) {
                          return null;
                        } else {
                          return "password doesn't match";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    providerobj.isloading
                        ? CircularProgressIndicator()

                        /// sign up button
                        : InkWell(
                            onTap: () {
                              // Todo : write code  to navigate to login screen on successful registration
                              if (_formKey1.currentState!.validate()) {
                                context
                                    .read<RegistrationScreenController>()
                                    .onRegistration(
                                        password: password.text,
                                        email: email.text,
                                        context: context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              // Todo : write code  to navigate to Login screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => signinscreen(),
                                  ));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
