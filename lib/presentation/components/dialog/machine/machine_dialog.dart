import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/features/machine/domain/entity/machine_entity.dart';
import 'package:vhack_client/features/machine/presentation/cubit/machine/machine_cubit.dart';
import 'package:vhack_client/presentation/components/button/small_button.dart';
import 'package:vhack_client/presentation/components/card/machine/machine_card.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'package:vhack_client/injection_container.dart' as di;

class MachineDialog extends StatefulWidget {
  final void Function()? onPressed;
  const MachineDialog({super.key, required this.onPressed});

  @override
  State<MachineDialog> createState() => _MachineDialogState();
}

class _MachineDialogState extends State<MachineDialog> {
  List<Map<String, dynamic>> machines = [
    {
      'machineID': '1',
      'machineName': 'Tractor',
      'machineURL':
          'https://image.made-in-china.com/202f0j00jAKVUBiRMwzv/4WD-Agricultural-Dump-Truck-Tractor-for-Paddy-Field.webp',
      'machineJob': 'Land Preparation',
      'machineStatus': true
    },
    {
      'machineID': '2',
      'machineName': 'Rotary Tiller',
      'machineURL':
          'https://image.made-in-china.com/2f0j00HsglrUKzscpu/1gqn220-Rotary-Tiller-for-Farm-Tractor-Gear-Drive-Cultivator-Beater-Rotary-Plowing-Tiller-Machine-CE-Orchard-Agriculture-Paddy-Dry-Field-Agricultural-Machinery.webp',
      'machineJob': 'Land Preparation',
      'machineStatus': true
    },
    {
      'machineID': '3',
      'machineName': 'Seeder',
      'machineURL':
          'https://inputs.kalgudi.com/data/p_images/1626153803268.jpeg',
      'machineJob': 'Seeding',
      'machineStatus': true
    },
    {
      'machineID': '4',
      'machineName': 'Transplanter',
      'machineURL':
          'https://5.imimg.com/data5/DS/CW/MY-24923732/4-rows-paddy-transplanter.png',
      'machineJob': 'Transplanting Seedlings',
      'machineStatus': true
    },
    {
      'machineID': '5',
      'machineName': 'Fertilizer Spreader',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrtCxk4msAjHrJEJQVx2DhuIxnQYBykMc30Q&usqp=CAUpesticide ',
      'machineJob': 'Fertilizer Application',
      'machineStatus': true
    },
    {
      'machineID': '6',
      'machineName': 'Pesticide Sprayer',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGpG_swboYFOc8soiN9w8x2WksY0akXjahmQ&usqp=CAU',
      'machineJob': 'Pest Control',
      'machineStatus': true
    },
    {
      'machineID': '7',
      'machineName': 'Harvester',
      'machineURL':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStb4I6vZHhMaikjt4nAb_r5HLUrZb6--tPw0vz9FsGa1Vpbd9fBBZjbAjXgYQfOu0Lf90&usqp=CAU',
      'machineJob': 'Harvesting',
      'machineStatus': true
    },
    {
      'machineID': '8',
      'machineName': 'Thresher',
      'machineURL':
          'https://bensonagro.com/media/front/images/electric-paddy-thresher.jpg',
      'machineJob': 'Threshing',
      'machineStatus': true
    },
    {
      'machineID': '9',
      'machineName': 'Drying Machine',
      'machineURL':
          'https://sc04.alicdn.com/kf/H60020543632a4be3848904ff904e0696m.jpg',
      'machineJob': 'Grain Drying',
      'machineStatus': true
    },
    {
      'machineID': '10',
      'machineName': 'Rice Mill',
      'machineURL':
          'https://sccgmachinery.com/wp-content/uploads/2021/09/7.png',
      'machineJob': 'Rice Milling',
      'machineStatus': true
    },
  ];

  void handleSelectedMachine(MachineEntity machineEntity) {
    BlocProvider.of<MachineCubit>(context).selectMachine(machineEntity);
    setState(() {});
  }

  bool isSelected(MachineEntity machineEntity) {
    return BlocProvider.of<MachineCubit>(context).isSelected(machineEntity);
  }

  @override
  Widget build(BuildContext context) {
    return buildMachineDialog(context);
  }

  Widget buildMachineDialog(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColor.getPrimaryColor(context)),
        height: 500,
        child: Material(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Machines',
                      style: CustomTextStyle.getTitleStyle(
                          context, 18, CustomColor.getTertieryColor(context))),
                  Text('Select your machine',
                      style: CustomTextStyle.getSubTitleStyle(
                          context, 15, CustomColor.getTertieryColor(context)))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (BlocProvider.of<MachineCubit>(context)
                  .selectedMachines
                  .isNotEmpty)
                buildListSelectedMachine(),
              Expanded(child: buildListMachine()),
              buildButtom(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListSelectedMachine() => SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              BlocProvider.of<MachineCubit>(context).selectedMachines.length,
          itemBuilder: (context, index) {
            MachineEntity eachMachine =
                BlocProvider.of<MachineCubit>(context).selectedMachines[index];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: CustomColor.getSecondaryColor(context)),
                  child: Center(
                      child: Text(
                    eachMachine.machineName!,
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getWhiteColor(context)),
                  ))),
            );
          },
        ),
      );

  Widget buildListMachine() => BlocProvider<MachineCubit>(
        create: (context) => di.sl<MachineCubit>()..getMachines(),
        child: BlocBuilder<MachineCubit, MachineState>(
          builder: (context, state) {
            if (state is MachineLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(state.machines.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildMachineCard(state.machines[index]));
                  }),
                ),
              );
            }
            if (state is MachineFailure) {
              return Center(
                child: Text(
                  state.failureTitle,
                  style: CustomTextStyle.getTitleStyle(
                      context, 21, CustomColor.getSecondaryColor(context)),
                ),
              );
            }
            if (state is MachineEmpty) {
              return Center(
                child: Text(
                  state.emptyTitle,
                  style: CustomTextStyle.getTitleStyle(
                      context, 21, CustomColor.getSecondaryColor(context)),
                ),
              );
            }
            return Container();
          },
        ),
      );

  Widget buildMachineCard(MachineEntity machineEntity) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
            color: CustomColor.getBackgroundColor(context)),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: MyNetworkImage(
              pathURL: machineEntity.machineImage!.avatarURL,
              width: 50,
              height: 50,
              radius: 50),
          title: Text(
            machineEntity.machineName!,
            style: CustomTextStyle.getTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
          subtitle: Text(
            machineEntity.machineDesc!,
            style: CustomTextStyle.getSubTitleStyle(
                context, 12, CustomColor.getTertieryColor(context)),
          ),
          trailing: isSelected(machineEntity)
              ? Icon(
                  Icons.check_circle,
                  color: CustomColor.getSecondaryColor(context),
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            handleSelectedMachine(machineEntity);
          },
        ),
      );
  Widget buildButtom(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: CustomColor.getTertieryColor(context)),
                borderRadius: BorderRadius.circular(12)),
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<MachineCubit>(context).reset();
            },
            child: Center(
                child: Text('Cancel',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getTertieryColor(context)))),
          ),
          MaterialButton(
            color: CustomColor.getSecondaryColor(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onPressed: widget.onPressed,
            child: Center(
                child: Text('Add Machine',
                    style: CustomTextStyle.getTitleStyle(
                        context, 12, CustomColor.getWhiteColor(context)))),
          ),
        ],
      );
}
