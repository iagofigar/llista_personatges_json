import 'package:scp/scp_model.dart';
import 'package:flutter/material.dart';

class SCPContainment extends StatelessWidget {
  final SCP scp;
  const SCPContainment({super.key, required this.scp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Special Containment Procedures'),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff000000), Color(0xff673d3d), Color(0xff454545)],
                    stops: [0.15, 0.85, 0.85],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
              )
          ),
          toolbarHeight: 75,
        ),
        body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 5, bottom: 10),
                  child: Text(scp.containment ?? "", style: const TextStyle(color: Colors.black, fontSize: 19))
                )
              ]
        )
    );
  }
}