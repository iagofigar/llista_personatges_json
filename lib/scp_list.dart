import 'package:scp/scp_card.dart';
import 'package:flutter/material.dart';
import 'scp_model.dart';

class SCPList extends StatelessWidget {
  final List<SCP> scps;
  const SCPList(this.scps, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: scps.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return SCPCard(scps[int]);
      },
    );
  }
}
