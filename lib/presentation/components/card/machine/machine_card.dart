import 'package:flutter/material.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class MachineCard extends StatelessWidget {
  final MachineEntity eachMachine;
  final VoidCallback onTap;
  const MachineCard(
      {super.key, required this.eachMachine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return buildMachineCard(context);
  }

  Widget buildMachineCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(12),
          color: CustomColor.getPrimaryColor(context)),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: UserAvatarCard(
              userAvatar: eachMachine.machineImage!.avatarURL, radius: 50),
          title: Text(
            eachMachine.machineName!,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${eachMachine.machineID}',
                style: CustomTextStyle.getSubTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
              ),
              Text(
                eachMachine.machineDesc!,
                style: CustomTextStyle.getSubTitleStyle(
                    context, 12, CustomColor.getTertieryColor(context)),
              )
            ],
          ),
          trailing:
              GestureDetector(onTap: onTap, child: buildTrailing(context))),
    );
  }

  Widget buildTrailing(BuildContext context) {
    if (eachMachine.machineStatus!) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.shade100),
        child: Text(
          'Active',
          style: CustomTextStyle.getTitleStyle(context, 12, Colors.black54),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.shade100),
        child: Text(
          'Inactive',
          style: CustomTextStyle.getTitleStyle(context, 12, Colors.black54),
        ),
      );
    }
  }
}
