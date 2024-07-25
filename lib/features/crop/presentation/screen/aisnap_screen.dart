// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:tflite/tflite.dart';
// import 'package:vhack_client/controller/provider/metric_provider.dart';
// import 'package:vhack_client/features/auth/domain/entity/user_entity.dart';
// import 'package:vhack_client/features/crop/domain/entity/crop_entity.dart';
// import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
// import 'package:vhack_client/presentation/components/button/text_button.dart';
// import 'package:vhack_client/features/crop/presentation/screen/aisnap_result/aisnap_nutrient.dart';
// import 'package:vhack_client/features/crop/presentation/screen/aisnap_result_screen.dart';
// import 'package:vhack_client/shared/constant/custom_appbar.dart';
// import 'package:vhack_client/shared/constant/custom_color.dart';
// import 'package:vhack_client/shared/constant/custom_snackbar.dart';
// import 'package:vhack_client/shared/constant/custom_textstyle.dart';
// import 'package:vhack_client/shared/util/avatar_data.dart';
// import 'package:vhack_client/shared/util/storage.dart';

// import '../../../../shared/util/services/crop_services.dart';

// class AISnapScreen extends StatefulWidget {
//   final UserEntity userEntity;
//   const AISnapScreen({super.key, required this.userEntity});

//   @override
//   State<AISnapScreen> createState() => _AISnapScreenState();
// }

// class _AISnapScreenState extends State<AISnapScreen> {
//   String? areaDefault;
//   List<String> areas = ['Rainfed Lowland', 'Irrigated Lowland', 'Upland'];
//   String monthDefault = "1 month";
//   List<String> months = [
//     '1 month',
//     '2 months',
//     '3 months',
//     '4 months',
//     '5 months',
//     '6 months'
//   ];
//   File? selectedImage;
//   List? _classifiedResult;
//   String? cropDisease, cropNutrient, cropHealth, cropPrecaution;
//   bool isLoading = false;
//   bool isPaddy = false;
//   double totalTime = 0.0;
//   String? resultCrop;
//   CropEntity? cropEntity;
//   AvatarData? cropImage;

//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final imagepicked = await ImagePicker().pickImage(source: source);
//       if (imagepicked == null) {
//         return;
//       }

//       setState(() {
//         selectedImage = File(imagepicked.path);
//       });

//       detectImage(imagepicked);
//     } on PlatformException catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future classifyImage(image) async {
//     String resultCrop = '';
//     _classifiedResult = null;

//     // Run tensorflowlite image classification model on the image
//     print("classification start $image");
//     final List? result = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 6,
//       threshold: 0.05,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     print("classification done");
//     setState(() {
//       if (image != null) {
//         selectedImage = File(image.path);
//         _classifiedResult = result!;
//         resultCrop = result[0]['label'];
//         //confidence = result[0]['confidence'];
//         setState(() {
//           cropDisease = resultCrop.substring(2, resultCrop.length);
//         });
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   void detectImage(var imagepick) async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String statusImage = await CropServices.getStatusImage(selectedImage!);
//       if (statusImage == 'YES') {
//         classifyImage(imagepick);
//         setState(() {
//           isPaddy = true;
//         });
//       } else {
//         setState(() {
//           cropDisease = 'This is Not Paddy';
//           isPaddy = false;
//         });
//         SnackBarUtil.showSnackBar(
//             'Please provide the image that related to paddy.', Colors.red);
//       }
//     } catch (e) {
//       SnackBarUtil.showSnackBar(e.toString(), Colors.red);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void getDetailCrop() async {
//     final metricProvider = Provider.of<MetricProvider>(context, listen: false);
//     final navigator = Navigator.of(context);
//     Stopwatch stopwatch = Stopwatch()..start();
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       List<Future<String>> futures = [
//         getNurtrient(selectedImage!),
//         getPrecaution(selectedImage!),
//         getOverallHealth(selectedImage!),
//       ];

//       List<String> results = await Future.wait(futures);

//       cropImage = await Storage.getURL(
//           selectedFile: selectedImage!,
//           userEntity: widget.userEntity,
//           path: 'crop');

//       setState(() {
//         cropNutrient = results[0];
//         cropPrecaution = results[1];
//         cropHealth = results[2];
//         cropEntity = CropEntity(
//             cropDisease: cropDisease,
//             cropNutrient: cropNutrient,
//             cropPrecaution: cropPrecaution,
//             cropImage: cropImage);
//       });
//       metricProvider.setNutrientHome(results[0]);
//       navigator.push(MaterialPageRoute(
//         builder: (context) => AISnapResultScreen(
//           userEntity: widget.userEntity,
//           cropCA: areaDefault!,
//           cropEntity: cropEntity!,
//         ),
//       ));
//     } catch (e) {
//       debugPrint(e.toString());
//       SnackBarUtil.showSnackBar(e.toString(), Colors.red);
//     } finally {
//       setState(() {
//         totalTime = (stopwatch.elapsedMilliseconds / 1000);
//         isLoading = false;
//       });

//       print('TOTAL TIME: $totalTime} Seconds');
//     }
//   }

//   Future<String> getNurtrient(File imageFile) async {
//     String cropNutrient = await CropServices.getNurtrient(imageFile);
//     return cropNutrient;
//   }

//   Future<String> getPrecaution(File imageFile) async {
//     String cropPrecaution =
//         await CropServices.getPrecaution(cropDisease: cropDisease!);
//     return cropPrecaution;
//   }

//   Future<String> getOverallHealth(File imageFile) async {
//     String cropHealth = await CropServices.getOverallHealth(imageFile);
//     return cropHealth;
//   }

//   Future loadImageModel() async {
//     Tflite.close();
//     String? result;
//     result = await Tflite.loadModel(
//         model: "assets/ai/model.tflite", labels: "assets/ai/labels.txt");
//     print(result);
//   }

//   @override
//   void initState() {
//     loadImageModel();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColor.getBackgroundColor(context),
//       appBar: CustomAppBar.BuildMainAppBar(context, false),
//       body: Center(
//         child: Column(
//           children: [
//             buildHeader(context),
//             const SizedBox(
//               height: 20,
//             ),
//             buildDropDownArea(),
//             buildDropDownCalender(),
//             const SizedBox(
//               height: 20,
//             ),
//             buildButtonForm(),
//             const SizedBox(
//               height: 20,
//             ),
//             buildBottomForm()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader(BuildContext context) {
//     if (selectedImage == null) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/DementiCare.png',
//             height: 200,
//             width: 200,
//             filterQuality: FilterQuality.high,
//             fit: BoxFit.cover,
//           ),
//           Text('Examine Your Paddy',
//               style: CustomTextStyle.getTitleStyle(
//                 context,
//                 18,
//                 CustomColor.getTertieryColor(context),
//               )),
//           Text('AI-Powered paddy analysis for optimal health',
//               style: CustomTextStyle.getSubTitleStyle(
//                 context,
//                 15,
//                 CustomColor.getTertieryColor(context),
//               ),
//               textAlign: TextAlign.center),
//         ],
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.file(
//                 selectedImage!,
//                 height: 200,
//                 width: MediaQuery.of(context).size.width,
//                 filterQuality: FilterQuality.high,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Text(
//                     'Error loading image: $error',
//                     style: CustomTextStyle.getTitleStyle(
//                         context, 15, CustomColor.getSecondaryColor(context)),
//                     textAlign: TextAlign.center,
//                   );
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Text(cropDisease ?? ' ',
//               style: CustomTextStyle.getTitleStyle(
//                 context,
//                 18,
//                 CustomColor.getTertieryColor(context),
//               )),
//           Text('AI-Powered paddy analysis for optimal health',
//               style: CustomTextStyle.getSubTitleStyle(
//                 context,
//                 15,
//                 CustomColor.getTertieryColor(context),
//               ),
//               textAlign: TextAlign.center),
//         ],
//       );
//     }
//   }

//   Widget buildDropDownArea() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 0.75),
//             borderRadius: BorderRadius.circular(12),
//             color: CustomColor.getPrimaryColor(context)),
//         child: DropdownButton<String>(
//           borderRadius: BorderRadius.circular(12),
//           elevation: 0,
//           hint: Text(
//             'Cultivation Area',
//             style: CustomTextStyle.getSubTitleStyle(context, 15, Colors.grey),
//           ),
//           underline: Container(),
//           value: areaDefault,
//           items: areas.map((valueItem) {
//             return DropdownMenuItem<String>(
//                 value: valueItem.toString(), child: Text(valueItem));
//           }).toList(),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 areaDefault = newValue;
//               });
//             }
//           },
//           isExpanded: true,
//           icon: Icon(
//             Icons.area_chart_outlined,
//             color: CustomColor.getSecondaryColor(context),
//           ),
//           iconSize: 32,
//           dropdownColor: CustomColor.getPrimaryColor(context),
//         ),
//       ),
//     );
//   }

//   Widget buildDropDownCalender() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 0.75),
//             borderRadius: BorderRadius.circular(12),
//             color: CustomColor.getPrimaryColor(context)),
//         child: DropdownButton<String>(
//           borderRadius: BorderRadius.circular(12),
//           underline: Container(),
//           value: monthDefault,
//           items: months.map((valueItem) {
//             return DropdownMenuItem<String>(
//                 value: valueItem.toString(), child: Text(valueItem));
//           }).toList(),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 monthDefault = newValue;
//               });
//             }
//           },
//           isExpanded: true,
//           icon: Icon(
//             Icons.calendar_month_outlined,
//             color: CustomColor.getSecondaryColor(context),
//           ),
//           iconSize: 32,
//           dropdownColor: CustomColor.getPrimaryColor(context),
//         ),
//       ),
//     );
//   }

//   Widget buildButtonForm() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 65,
//             child: IconTextButton(
//               buttonTitle: 'Upload Image',
//               buttonIcon: Icons.image_outlined,
//               onPressed: () {
//                 pickImage(ImageSource.gallery);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Text('OR',
//                 style: CustomTextStyle.getTitleStyle(context, 18, Colors.grey)),
//           ),
//           SizedBox(
//             height: 65,
//             child: IconTextButton(
//               buttonTitle: 'Snap your paddy',
//               buttonIcon: Icons.camera_alt,
//               onPressed: () {
//                 pickImage(ImageSource.camera);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildBottomForm() {
//     if (isLoading) {
//       return Center(
//         child: CircularProgressIndicator(
//           color: CustomColor.getSecondaryColor(context),
//         ),
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: SizedBox(
//           height: 50,
//           child: TextOnlyButton(
//               buttonTitle: 'Confirm',
//               onPressed: () {
//                 if (areaDefault == null || selectedImage == null) {
//                   SnackBarUtil.showSnackBar(
//                     'Please Select Cultivation Area and Image',
//                     Colors.red,
//                   );
//                   return;
//                 }

//                 getDetailCrop();
//               },
//               isMain: true,
//               borderRadius: 12),
//         ),
//       );
//     }
//   }
// }
