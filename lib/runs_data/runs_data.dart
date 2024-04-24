

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

class RunsData extends GetxController{

  RxInt total_runs = 0.obs;
  RxInt total_wickets = 0.obs;
  RxDouble total_overs = 0.0.obs;
  RxInt totoal_balls = 0.obs;
  RxBool isSetTarget = false.obs;
  RxInt setRuns = 1.obs;
  RxInt setBalls = 1.obs;
  int setRunsTemp = 0;
  int setBallsTemp = 0;

  void set_calculation(){
    if(isSetTarget== true && setBalls > 0 && setRuns > 0){
      setRuns.value = ( setRunsTemp - total_runs.value );
      setBalls.value = ( setBallsTemp - totoal_balls.value );
    }
  }

  void calclulate_overs(){
    int temp = (totoal_balls.value ~/ 6);
    int temp2 = (totoal_balls.value - (temp*6));
    total_overs.value = temp + (temp2 /10);

    set_calculation();
  }

  void dot_ball(){
    totoal_balls.value++;
    calclulate_overs();
  }

  void single_run(){
    totoal_balls.value +=1;
    total_runs +=1;

    calclulate_overs();
  }

  void double_run(){
    totoal_balls.value +=1;
    total_runs +=2;

    calclulate_overs();
  }

  void three_run(){
    totoal_balls.value +=1;
    total_runs +=3;

    calclulate_overs();
  }

  void four_run(){
    totoal_balls.value +=1;
    total_runs +=4;

    calclulate_overs();
  }

  void six_run(){
    totoal_balls.value +=1;
    total_runs +=6;

    calclulate_overs();
  }

  void wicket(){
    total_wickets++;
    totoal_balls++;
    calclulate_overs();

    if(total_wickets.value >=10){
      Get.snackbar('Game Over', 'Click to start new game',);

      // showDialog(context: context, builder: )
    }
  }

  void wide_ball(int num){
    total_runs.value = total_runs.value + num + 1;

    set_calculation();
  }

  void no_ball(int num,int free_hit){
    total_runs.value = total_runs.value + num + 1 + free_hit;

    totoal_balls++;
    calclulate_overs();
  }

  void clear_all(){
    total_wickets.value=0;
    total_runs.value=0;
    totoal_balls.value=0;
    total_overs.value=0.0;

    setRuns.value = 1;
    setBalls.value = 1;
    setRunsTemp =0;
    setBallsTemp =0;
    isSetTarget.value = false;
  }

  void set_target(String runs,String overs){
    int? run = int.tryParse(runs);
    setRuns.value = run!;

    List<String> b1 = overs.split('.');

    int t1 = int.parse(b1[0]);
    int t2 = int.parse(b1[1]);

    setBalls.value = (t1 * 6)+t2;

    setBallsTemp = setBalls.value;
    setRunsTemp = setRuns.value;
  }

}