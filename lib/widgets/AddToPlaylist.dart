import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_guide/objects/globals.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_guide/widgets/CreatePlaylist.dart';
import 'package:fit_guide/widgets/MainPage.dart';
class AddToPlaylist extends StatefulWidget {
  AddToPlaylist({Key? key}) : super(key: key);

  @override
  _AddToPlaylistState createState() => _AddToPlaylistState();
}
  class _AddToPlaylistState extends State<AddToPlaylist> {
  var isSelected = List.filled(globals.exerciseList.length, false);
  var exerciseNames = [];
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {Navigator.pop(context);},
            child: Icon(Icons.arrow_back_outlined),
          ),
          title: Text('Add Workouts',
          style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.pink,
          actions: [GestureDetector(
            onTap:(){
              addPlaylist();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()));} ,
            child: Icon(Icons.addchart),
          )],
        ),
        body:ListView.separated(
          itemCount: globals.exerciseList.length,
          separatorBuilder: (context,index) {
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child:
              ListTile(
                title: Text('${globals.exerciseList[index].name}'),
                selected: isSelected[index],
                selectedTileColor: Colors.red,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(globals.exerciseList[index].image),
                  backgroundColor: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                    if(isSelected[index]) {
                      exerciseNames.add(globals.exerciseList[index].name);
                    }
                    else {
                      exerciseNames.remove(globals.exerciseList[index].name);
                    }
                  });

                },
              )
            );

          },
        )
      );
  }
Future<void> addPlaylist() async
{
  String combine = "";
  exerciseNames.forEach((element) => combine = combine + element + ",");
  await FirebaseDatabase.instance.reference().child("users/${globals.userKey}/playlists/${playlistNameController.text}").set(
      {
        "name" : playlistNameController.text,
        "workouts": combine,
        "description" : descriptionController.text,
      }
  );
}

  }

