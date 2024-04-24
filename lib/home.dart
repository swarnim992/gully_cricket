import 'package:cricbuzz_demo/components/don_button.dart';
import 'package:cricbuzz_demo/runs_data/runs_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

import 'components/dialogs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  RunsData runsData = RunsData();
  final data1 = TextEditingController() ;
  final data2 = TextEditingController();

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

  void _wideDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wide'),
          content: Text('Select the Wide with runs'),
          actions: <Widget>[
            Row(
              children: [
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
            ),
          ],
        );
      },
    );
  }

  void _noDialog(BuildContext context) {
    int val1=0;
    int val2=0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Ball'),
          content: Text('Select the No ball runs with Free hit'),
          actions: <Widget>[
            Container(
              width: Get.width*1,
              height: 250,
              child: Column(
                children: [
                  Text("Select No ball Runs"),

                  Expanded(
                    child: SpinBox(
                      min: 0,
                      max: 6,
                      onChanged: (value) => val1=value.toInt(),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Text("Select Free Hit Runs"),

                  Expanded(
                    child: SpinBox(
                      min: 0,
                      max: 6,
                      onChanged: (value) => val2=value.toInt(),
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextButton(
                      onPressed: (){
                        runsData.no_ball(val1, val2);
                        Navigator.of(context).pop();
                      },
                      child: Text('Submit'))
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _setTargetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Target'),
          content: Text('Enter Runs and overs'),
          actions: <Widget>[
            TextField(
              controller: data1,
              decoration: InputDecoration(
                hintText: 'Runs',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),

            TextField(
              controller: data2,
              decoration: InputDecoration(
                hintText: 'Overs',
              ),
              keyboardType: TextInputType.number,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('Cancel')),

                TextButton(onPressed: (){
                  runsData.set_target(data1.text, data2.text);
                  Navigator.of(context).pop();
                },
                    child: Text('Submit')),
              ],
            )
          ],
        );
      },
    );
  }

  Dialogs dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Gully Cricket Score Board'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[200],

          actions: [
            IconButton(
                onPressed: (){
                  runsData.isSetTarget.value = true;

                  _setTargetDialog(context);
                },
                icon: Icon(Icons.crisis_alert),
              iconSize: 40,
              color: Colors.white,
            ),
          ],
        ),
      backgroundColor: Colors.blue[50],

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/screen-0.jpg'),opacity: 0.8,
          fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:

              Center(

                child: Obx(()=> (runsData.setBalls.value<=0 || runsData.setRuns.value<=0) && (runsData.isSetTarget.value==true )?

                AlertDialog(
                      title: Text('Game Over'),
                      content: Text('Click to start new game'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Close the dialog box
                            runsData.clear_all();
                            runsData.isSetTarget.value = false;
                          },
                          child: Text('Ok'),
                        ),
                      ],
                    ) :
                    Container(
                      width: 200,
                      color: Colors.white70,
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black,),
                            children: [
                              TextSpan(
                                text: "${runsData.total_runs.toString()}/${runsData.total_wickets.toString()}",
                                style: TextStyle(fontSize: 50 , fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: '   ',
                                style: TextStyle(fontSize: 30),
                              ),

                              TextSpan(
                                text: runsData.total_overs.toString(),
                                style: TextStyle(
                                    fontSize: 30 ,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red),
                              ),
                            ]
                        ),

                      ),
                    ),
                ),


              ),
            ),

            SizedBox(height: 40,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DonButton(
                    title: '0',
                    onPress: (){
                      runsData.dot_ball();
                    },
                  width: Get.width * 0.20,
                ),

                DonButton(
                    title: '1',
                    onPress: (){
                      runsData.single_run();
                    },
                  width: Get.width * 0.20,
                ),

                DonButton(
                    title: '2',
                    onPress: (){
                      runsData.double_run();
                    },
                  width: Get.width * 0.20,
                ),

                DonButton(
                    title: '3',
                    onPress: (){
                      runsData.three_run();
                    },
                  width: Get.width * 0.20,
                ),
              ],
            ),

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DonButton(
                  title: '4',
                  onPress: (){
                    runsData.four_run();
                  },
                  width: Get.width * 0.20,
                ),

                DonButton(
                  title: '6',
                  onPress: (){
                    runsData.six_run();
                  },
                  width: Get.width * 0.20,
                ),


                DonButton(
                  title: 'Wide Ball',
                  onPress: (){
                    _wideDialog(context);
                  },
                  width: Get.width * 0.20,
                ),

                DonButton(
                  title: 'No Ball',
                  onPress: (){
                    _noDialog(context);
                  },
                  width: Get.width * 0.20,
                ),
              ],
            ),

            SizedBox(height: 15,),

            DonButton(
                buttonColor: Colors.red,
                textColor: Colors.white,
                title: 'Wicket',
                onPress: (){
                  runsData.wicket();

                  if(runsData.total_wickets.value >=10){
                    _showDialog(context);
                  }
                }),

            SizedBox(height: 15,),

            Obx(() => runsData.isSetTarget.value ?
            Container(
              color: Colors.black54,
              width: Get.width * 0.85,
              alignment: Alignment.center,
              child: Text('Need ${runsData.setRuns.value} runs in ${runsData.setBalls.value} balls',
                style: TextStyle(fontSize: 26,color: Colors.amberAccent,
                    fontWeight: FontWeight.w600),),
            ) : Text(''),),

          ],
        ),
      ),

      floatingActionButton: TextButton.icon(
          onPressed: (){
            runsData.clear_all();
          },
          label: Text("Clear All",style: TextStyle(color: Colors.black),),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.greenAccent[100]),),
        icon: Icon(Icons.cleaning_services_rounded,color: Colors.black,),
      ),

    );
  }
}
