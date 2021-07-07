import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import  'package:fit_guide/objects/exercise.dart';
import 'package:fit_guide/objects/globals.dart';


class Dictionary extends StatefulWidget {

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  List<Map<dynamic,dynamic>> workouts = [];
  List<Map<dynamic,dynamic>> workoutNames = [];
  _DictionaryState() {
    // ignore: unnecessary_statements
    FirebaseDatabase.instance.reference().child("workouts").once()
        .then((datasnapshot) {
        workouts.clear();
        workoutNames.clear();
        Map<dynamic, dynamic> values = datasnapshot.value;
        values.forEach((key, values) {
          workouts.add(values);
        });
        for (int count = 0; count < workouts.length; count++) {
          workouts[count].forEach((key, value) {
            workoutNames.add(value);
          });
      }
        globals.exerciseList.clear();
        for (int count = 0; count <workoutNames.length; count++) {
          globals.exerciseList.add(Exercise('${workoutNames[count]["name"]}',
          '${workoutNames[count]["muscle"]}', '${workoutNames[count]["image"]}'));
        }
        setState(()
        {

        });
    }).catchError((onError) {
      print("Something went wrong");
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: ListView.separated(
                    itemCount: globals.exerciseList.length,
                    separatorBuilder: (context,index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text('${globals.exerciseList[index].name}'),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(globals.exerciseList[index].image),
                          backgroundColor: Colors.white,
                        ),
                        trailing: Text('${globals.exerciseList[index].muscle}'),
                      );
                    },
    )
  );
    }
  }

