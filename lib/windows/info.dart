import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text("На данный момент, этот проект находится в разработке.\n\n Гадель Загрутдинов\n\n v0.1a",textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
