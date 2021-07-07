import 'package:fit_guide/widgets/AddToPlaylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_guide/objects/globals.dart';
var playlistNameController = TextEditingController();
var descriptionController = TextEditingController();
class CreatePlaylist extends StatefulWidget
{
  @override
  _CreatePlaylist createState() => _CreatePlaylist();
}

class _CreatePlaylist extends State<CreatePlaylist> {

  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.clear),
        ),
        title: Text('Create a new Playlist',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pink,
      ),
      body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: playlistNameController,
              maxLength: 20,
              onChanged: (value) {
                setState(() {
                });
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Playlist Name',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color:Colors.pink),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            TextFormField(
              controller: descriptionController,
              maxLength: 50,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color:Colors.pink),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            new Container(
              height: 50,
            width: 200,
            child: ElevatedButton(onPressed: () async {


              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToPlaylist()));

            },
            child: const Text("Create Playlist"),
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
      ),
            )
          ],
        ),
      )
      )
    );
  }
}