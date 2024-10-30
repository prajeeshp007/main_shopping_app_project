import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/controller/signin_screen_controller.dart';
import 'package:main_shopping_app_project/view/registration_screen/registration_screen.dart';
import 'package:provider/provider.dart';

class signinscreen extends StatefulWidget {
  const signinscreen({super.key});

  @override
  State<signinscreen> createState() => _signinscreenState();
}

class _signinscreenState extends State<signinscreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Todo : write code  create controllers and form keys
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                        'https://i.pinimg.com/originals/d6/db/14/d6db1486aac8e639c817d8a8388f31ba.jpg'),
                    Container(
                      child: Text(
                        "Member Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // email input fied
                    TextFormField(
                      controller: _emailController,
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
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // password input field
                    TextFormField(
                      controller: _passwordController,
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
                      obscureText: true,
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 10,
                                ),
                              ),
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Forgot password",
                          style: TextStyle(
                            color: Color(0xff1a75d2),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SigninScreenController>().onSignin(
                              mail: _emailController.text,
                              psswrd: _passwordController.text,
                              context: context);
                        }
                        // Todo : write code  to navigate to home screen on successful Login with registered credentials
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Sign in",
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
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              // Todo : write code  to navigate to registration screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xff1a75d2),
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
