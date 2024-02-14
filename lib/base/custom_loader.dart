import 'package:flutter/material.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 105,
        width: 105,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(105),
            color: Colors.blueGrey.shade800
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
