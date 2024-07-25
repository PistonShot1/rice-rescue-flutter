import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/presentation/components/card/machine/machine_card.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/components/textfield/search_textfield.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';

class MachinesAllScreen extends StatelessWidget {
  List<MachineEntity> machines;
  MachinesAllScreen({super.key, required this.machines});

  final TextEditingController tcSearch = TextEditingController();

  void deleteMachine(MachineEntity machineEntity, BuildContext context) {
    BlocProvider.of<MachineCubit>(context)
        .deleteMachine(machineEntity: machineEntity);
  }

  void updateMachine(MachineEntity machineEntity, BuildContext context) {
    bool status = !machineEntity.machineStatus!;
    BlocProvider.of<MachineCubit>(context).updateMachine(
        machineEntity: MachineEntity(
            machineID: machineEntity.machineID,
            machineName: machineEntity.machineName,
            machineDesc: machineEntity.machineDesc,
            machineImage: machineEntity.machineImage,
            machineOwnerID: machineEntity.machineOwnerID,
            machineStatus: status,
            machinePICsID: machineEntity.machinePICsID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      body: Column(
        children: [
          buildSearchTextfield(),
          Expanded(
              child: ListView.builder(
            itemCount: machines.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: buildMachineCard(machines[index], context));
            },
          ))
        ],
      ),
    );
  }

  Widget buildSearchTextfield() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: SearchTextfield(
          title: 'Search your machines',
          onChanged: (p0) {},
          tcSearch: tcSearch),
    );
  }

  Widget buildMachineCard(MachineEntity machineEntity, BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          backgroundColor: Colors.red,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
          icon: Icons.delete_outline,
          onPressed: (context) {
            deleteMachine(machineEntity, context);
          },
        )
      ]),
      child: MachineCard(
        eachMachine: machineEntity,
        onTap: () {
          updateMachine(machineEntity, context);
        },
      ),
    );
  }
}
