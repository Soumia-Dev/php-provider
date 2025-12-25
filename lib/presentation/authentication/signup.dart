import 'package:flutter/material.dart';

import '../../components/crud.dart';
import '../../components/text_field.dart';
import '../../constant/link_api.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Crud crud = Crud();
  bool isLoading = false;

  void signup() async {
    setState(() {
      isLoading = true;
    });
    var result = await crud.postRequest(linkSignupApi, {
      "email": emailController.text,
      "password": passwordController.text,
      "userName": nameController.text,
    });
    setState(() {
      isLoading = false;
    });
    if (result != null && result['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("signup with successful ✅"),
          duration: Duration(seconds: 4),
        ),
      );
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Image.asset("assets/notes.png", width: 200, height: 200),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Text("Sign Up Page", style: TextStyle(fontSize: 40)),
          ),
          SizedBox(height: 40),
          Form(
            key: globalKey,
            child: Column(
              children: [
                TextFieldBuild(hint: "full name", myController: nameController),
                TextFieldBuild(hint: "emil", myController: emailController),
                TextFieldBuild(
                  hint: "password",
                  myController: passwordController,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      isLoading ? null : signup();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 40),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text("Sign Up"),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },

              child: Text(
                "i have already an account",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
