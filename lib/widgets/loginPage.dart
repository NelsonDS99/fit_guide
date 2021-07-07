import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_guide/widgets/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_guide/objects/globals.dart';
class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);


  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage>{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
      leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
     },
      child: Icon(Icons.arrow_back),
    ),
      title: Text('Login Page',
        style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.pink,
    ),
      body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.pink)
            ),

            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            controller: passwordController,
           style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.pink)
            ),
       ),
        ),
          Padding(padding: EdgeInsets.symmetric(vertical:50, horizontal: 20)),
          new Container(
            width: 200,
            height: 90,
            child: new ElevatedButton(onPressed: () async{
              try {
                await Firebase.initializeApp();
                UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                globals.email = emailController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );

  }
}

