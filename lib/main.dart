import 'package:flutter/material.dart';
import 'dart:async';
import 'scp_model.dart';
import 'scp_list.dart';
import 'new_scp_form.dart';

void main() => runApp(const MyApp());
int scpCounter = 1;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My fav SCPs',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Site-█ SCPs'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SCP> initialSCPs = [SCP('1'), SCP('2'), SCP('3'), SCP('4'), SCP('5'),
    SCP('6'), SCP('7'), SCP('8'), SCP('9'), SCP('10')];

  Future _showNewSCPForm() async {
    SCP newSCP = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return AddSCPFormPage(scpCounter);
    }));
    //print(newSCP);
    scpCounter++;
    initialSCPs.add(newSCP);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
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

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewSCPForm,
          ),
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: Center(
            child: SCPList(initialSCPs),
          )),
    );
  }
}
