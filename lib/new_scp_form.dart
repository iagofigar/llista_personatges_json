import 'package:scp/scp_model.dart';
import 'package:flutter/material.dart';


class AddSCPFormPage extends StatefulWidget {
  final int scpCounter;
  const AddSCPFormPage(this.scpCounter, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddSCPFormPageState createState() => _AddSCPFormPageState();
}

class _AddSCPFormPageState extends State<AddSCPFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Please insert the title of the SCP'),
      ));
    } else {
      var newSCP = SCP((widget.scpCounter + 10).toString());
      (SCP); newSCP.number = "SCP-XXXX-${widget.scpCounter}";
      newSCP.name = nameController.text;
      Navigator.of(context).pop(newSCP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new SCP'),
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
      body: Container(
        //color: Colors.white,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/scplogo.png"),
            fit: BoxFit.fitWidth,
          ),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'SCP Title',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    child: const Text('Submit SCP', style: TextStyle(color: Colors.white),),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
