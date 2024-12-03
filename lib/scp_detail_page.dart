import 'package:flutter/material.dart';
import 'scp_model.dart';
import 'dart:async';
import 'scp_containment.dart';


class SCPDetailPage extends StatefulWidget {
  final SCP scp;
  const SCPDetailPage(this.scp, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SCPDetailPageState createState() => _SCPDetailPageState();
}

class _SCPDetailPageState extends State<SCPDetailPage> {
  final double scpAvatarSize = 150.0;
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.scp.risk.toDouble();  // Inicializa _sliderValue con el valor de risk del objeto scp
  }

  Widget get addYourRisk {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRisk) {
                    setState(() {
                      _sliderValue = newRisk;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRiskButton,
      ],
    );
  }

  void updateRisk() {
    if (_sliderValue >= 6) {
      _riskErrorDialog();
      setState(() {
        widget.scp.risk = _sliderValue.toInt();
      });
    } else {
      setState(() {
        widget.scp.risk = _sliderValue.toInt();
      });
    }

  }

  Future<void> _riskErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Possible Containment Breach'),
            content: const Text("Activate lockdown and Special Containment Procedures of the entity, if any, and contact a nearby MTF squad"),
            actions: <Widget>[
              TextButton(
                child: const Text('Continue', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRiskButton {
    return ElevatedButton(
      onPressed: () => updateRisk(),
      child: const Text('Submit', style: TextStyle(color: Colors.white)),
    );
  }

  Widget get scpImage {
    return Hero(
      tag: widget.scp,
      child: Container(
        height: scpAvatarSize,
        width: scpAvatarSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
            image: DecorationImage(fit: BoxFit.cover, image: widget.scp.image ?? NetworkImage(widget.scp.imageUrl ?? ""))),
      ),
    );
  }

  Widget get risk {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.report_problem,
          size: 40.0,
          color: widget.scp.risk >= 6 ? Colors.red : Colors.black,
        ),
        Text('${widget.scp.risk}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get scpProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          scpImage,
          Text(widget.scp.number.toString(), style: const TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('Title: ${widget.scp.name}', style: const TextStyle(color: Colors.black, fontSize: 20.0)),
          RichText(
              text: TextSpan(
                  text: 'Object Class: ',
                  style: const TextStyle(color: Colors.black, fontSize: 20.0),
                  children: [
                    TextSpan(text: '${widget.scp.scpClass}', style: TextStyle(color: widget.scp.color, fontSize: 20.0))
                  ]
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: risk,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: Text('${widget.scp.number}'),
        toolbarHeight: 75,
      ),
      body: ListView(
        children: <Widget>[scpProfile, addYourRisk,
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset("assets/scplogo.png", width: 250, height: 250),
                if(widget.scp.containment == "")
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.85)),
                    child: const Center(
                      child: Text("This entity is pending or currently undergoing approval. \r\nContainment procedures will be added when approved.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                      )
                    )
                  )
                else
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return SCPContainment(scp: widget.scp);
                      }));
                    },
                    child: const Text("               \r\n               \r\n                 \r\n                     \r\n               \r\n               \r\n                 \r\n                     \r\n")
                  )
              ])
        )]
      ),
    );
  }
}
