import 'package:scp/scp_model.dart';
import 'scp_detail_page.dart';
import 'package:flutter/material.dart';


class SCPCard extends StatefulWidget {
  final SCP scp;

  const SCPCard(this.scp, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SCPCardState createState() => _SCPCardState(scp);
}

class _SCPCardState extends State<SCPCard> {
  SCP scp;
  String? renderUrl;

  _SCPCardState(this.scp);

  @override
  void initState() {
    super.initState();
    renderSCPPic();
  }

  Widget get scpImage {
    var scpAvatar = Hero(
      tag: scp,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: scp.image ?? NetworkImage(widget.scp.imageUrl ?? ""))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage("assets/dataexpunged.jpg"), fit: BoxFit.contain)
      )
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: scpAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderSCPPic() async {
    await scp.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = scp.imageUrl;
      });
    }
  }

  Widget get scpCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: const Color(0xFFF8F8F8),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  widget.scp.number.toString(),
                  style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.report_problem, color: widget.scp.risk > 6 ? Colors.red : Colors.black),
                    Text(': ${widget.scp.risk}/10', style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSCPDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SCPDetailPage(scp);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showSCPDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              scpCard,
              Positioned(top: 7.5, child: scpImage),
            ],
          ),
        ),
      ),
    );
  }
}
