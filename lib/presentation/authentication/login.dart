import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/crud.dart';
import '../../components/text_field.dart';
import '../../constant/link_api.dart';
import '../home.dart';
import '../provider/user_model_provider.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Crud crud = Crud();
  bool isLoading = false;
  void login() async {
    setState(() {
      isLoading = true;
    });
    var result = await crud.postRequest(linkLoginApi, {
      "email": emailController.text,
      "password": passwordController.text,
    });
    setState(() {
      isLoading = false;
    });
    if (result != null) {
      if (result['status'] == 'success') {
        context.read<UserModelProvider>().onUpdateUser({
          "user_id": result['data']['id'],
          "user_email": result['data']['email'],
          "user_name": result['data']['user_name'],
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("login with successful ✅"),
            duration: Duration(seconds: 4),
          ),
        );
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      } else if (result['status'] == 'fail') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("please verify your information ❗"),
            duration: Duration(seconds: 2),
          ),
        );
      }
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
            child: Text("Login Page", style: TextStyle(fontSize: 40)),
          ),
          SizedBox(height: 40),
          Form(
            key: globalKey,
            child: Column(
              children: [
                TextFieldBuild(hint: "emil", myController: emailController),
                TextFieldBuild(
                  hint: "password",
                  myController: passwordController,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      isLoading ? null : login();
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
                      : Text("Login"),
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
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              child: Text(
                "create new account",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
