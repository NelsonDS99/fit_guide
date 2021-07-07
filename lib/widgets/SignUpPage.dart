import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_guide/widgets/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_guide/objects/globals.dart';
class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);


  @override
  _SignUpPageState createState() => _SignUpPageState();
}
  class _SignUpPageState extends State<SignUpPage> {
final emailController = TextEditingController();
final passwordController = TextEditingController();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
    @override
    Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
      leading: GestureDetector(
        onTap: () {Navigator.pop(context);},
        child: Icon(Icons.arrow_back_outlined),
      ),
      title: Text('Sign Up Page',
      style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.pink,
    ),
      body : Center(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextFormField(
          controller: firstNameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'First Name',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.pink)
            ),
            suffixIcon: Icon(
              Icons.error,
            ),
          ),
        ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            controller: lastNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.pink)
              ),
              suffix: Icon(
                Icons.error,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color:Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.pink)
              ),
              suffix: Icon(
                Icons.error,
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
              suffix: Icon(
                Icons.error,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          new Container(
            width: 200,
            height: 90,
            child: new ElevatedButton(onPressed: () async {
              try {
                await Firebase.initializeApp();
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              var timestamp = new DateTime.now().millisecondsSinceEpoch;
              FirebaseDatabase.instance.reference().child("users/user-$timestamp").set(
                  {
                    "name" : firstNameController.text + " " + lastNameController.text,
                    "email": emailController.text
                  }).then((value) {
                    print("Successfully added the user");
              }).catchError((onError){
                print("Failed: " + onError.toString());
              });
            },
                child: const Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
            ),
            ),
          )
      ]),
      ),
      ),
      
    );
  }
  }

