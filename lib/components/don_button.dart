


import 'package:flutter/material.dart';

class DonButton extends StatelessWidget {

  const DonButton({
    Key? key,
    this.buttonColor = Colors.white54,
    this.textColor = Colors.black,
    required this.title,
    required this.onPress,
    this.width = 200,
    this.height = 50,
    this.loading = false,
  }) : super(key: key);

  final bool loading;
  final String title;
  final double height , width;
  final VoidCallback onPress;
  final Color textColor,buttonColor;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: loading ? Center(child: CircularProgressIndicator()) :
        Center(child: Text(title,style: TextStyle(color: textColor,fontWeight: FontWeight.w500),), ),
      ),
    );
  }
}
