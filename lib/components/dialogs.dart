
import 'package:get/get.dart';
import 'package:cricbuzz_demo/runs_data/runs_data.dart';
import 'package:flutter/material.dart';

class Dialogs{

  RunsData runsData = RunsData();

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Click to start new game'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog box
                runsData.clear_all();
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }



  void wideDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wide'),
          content: Text('Select the Wide with runs'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog box
                runsData.wide_ball(0);
                Navigator.of(context).pop();
              },
              child: Text('0'),
            ),
            TextButton(
              onPressed: () {
                runsData.wide_ball(1);
                Navigator.of(context).pop();
              },
              child: Text('1'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog box
                runsData.wide_ball(2);
                Navigator.of(context).pop();
              },
              child: Text('2'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog box
                runsData.wide_ball(4);
                Navigator.of(context).pop();
              },
              child: Text('4'),
            ),
          ],
        );
      },
    );
  }
}