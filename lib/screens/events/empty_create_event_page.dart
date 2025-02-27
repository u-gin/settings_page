import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:settings_page/screens/events/event_schedule.dart';
import 'package:settings_page/screens/events/mhc_gallery.dart';
import 'package:settings_page/screens/schedule/empty_schedule_screen.dart';
import 'package:settings_page/util/exports.dart';
import 'package:settings_page/widgets/timeline_widget.dart';
import 'package:widget_mask/widget_mask.dart';

class EmptyCreateEventPage extends StatefulWidget {
  @override
  State<EmptyCreateEventPage> createState() => _EmptyCreateEventPageState();
}

class _EmptyCreateEventPageState extends State<EmptyCreateEventPage> {
  bool isEditing = false;
  bool edited = false;
  String initialText = "lbl_untitled_event".tr;
  late String tempText;
  late TextEditingController _editingController;
  bool showError = true;
  final ImagePicker _picker = ImagePicker();
  dynamic imageFile;
  Color? appBarItemsColor;

  checkPermission(var source) async {
    var galleryStatus = await Permission.photos.status;
    if (galleryStatus.isGranted) {
      if (source == "gallery") {
        chooseFromGallery();
      } else if (source == "camera") {
        takePhotoWithCamera();
      } else {
        Get.to(MHCGallery());
      }
    } else {
      await Permission.photos.request();
    }
  }

  void chooseFromGallery() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void takePhotoWithCamera() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget imagePopulator(dynamic imageFile) {
    if (imageFile.runtimeType == String) {
      return CommonImageView(
        imagePath: imageFile,
      );
    }
    return CommonImageView(
      file: imageFile,
    );
  }

  @override
  void initState() {
    _editingController = TextEditingController(text: initialText);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(height * 0.32),
              child: Stack(
                children: [
                  WidgetMask(
                    blendMode: BlendMode.srcATop,
                    childSaveLayer: true,
                    mask: FittedBox(
                      fit: BoxFit.fill,
                      child: imagePopulator(imageFile),
                    ),
                    child: CommonImageView(
                      svgPath: "assets/images/img_background_appbar.svg",
                    ),
                  ),
                  AppbarWidget(
                    itemsColor:
                        imageFile == null ? appBarItemsColor : Colors.white,
                    hasActions: true,
                    appBarTitle: "lbl_create_event".tr,
                    trailingWidget: Constants.trailingWidget(
                      "assets/images/img_menu.svg",
                      () {},
                      color:
                          imageFile == null ? appBarItemsColor : Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.239,
                      right: 24.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        checkPermission("camera");
                                      },
                                      child: Text(
                                        "lbl_take_a_photo".tr,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Constants.fromHex("#007AFF"),
                                          letterSpacing: 0.38,
                                        ),
                                      ),
                                      isDefaultAction: true,
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        checkPermission("gallery");
                                      },
                                      child: Text(
                                        "lbl_add_from_device".tr,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Constants.fromHex("#007AFF"),
                                          letterSpacing: 0.38,
                                        ),
                                      ),
                                      isDefaultAction: true,
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        imageFile = await Get.to(MHCGallery());
                                        setState(() {});
                                      },
                                      child: Text(
                                        "msg_add_from_mhc_ga".tr,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          color: Constants.fromHex("#007AFF"),
                                          letterSpacing: 0.38,
                                        ),
                                      ),
                                      isDefaultAction: true,
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.close(1);
                                    },
                                    isDestructiveAction: true,
                                    child: Text(
                                      'Cancel'.tr,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Constants.fromHex("#007AFF"),
                                        letterSpacing: 0.38,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CommonImageView(
                            imagePath: "assets/images/img_icon_camera.png",
                          )),
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                    child: Container(
                  width: width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Constants.inactiveStatusColorGray,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Text(
                                  "lbl_draft".tr,
                                  style: AppStyle.crumbTextColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: showError ? 14.0 : 24,
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            _editTitleTextField(),
                            SizedBox(
                              height: showError ? 14.0 : 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => GeneralInfoPage());
                              },
                              child: TimelineWidget(
                                isLast: false,
                                isFirst: true,
                                tileText: "msg_general_informa".tr,
                                tileIcon: showError
                                    ? "assets/images/img_general_err.svg"
                                    : "assets/images/img_general.svg",
                                indicatorColor: Constants.gray100,
                                tileTextColor: Constants.gray900,
                                showError: showError,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => EventSchdule());
                              },
                              child: TimelineWidget(
                                isLast: true,
                                isFirst: false,
                                tileText: "lbl_event_schedule".tr,
                                tileIcon: showError
                                    ? "assets/images/img_event_sch_err.svg"
                                    : "assets/images/img_even_sch.svg",
                                indicatorColor: Constants.gray100,
                                tileTextColor: Constants.gray900,
                                showError: showError,
                              ),
                            ),
                            Constants.spaceLargeColumn,
                            Constants.spaceLargeColumn,
                            Constants.spaceLargeColumn,
                            Button(
                              onPressed: () {
                                //Get.to(AccountDeletedPage());
                                setState(() {
                                  showError = !showError;
                                });
                              },
                              text: "lbl_publish_event".tr,
                            ),
                          ],
                        ),
                      ]),
                )))));
  }

  Widget _editTitleTextField() {
    tempText = initialText;
    if (isEditing)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              isEditing = false;
            });
          },
          autofocus: true,
          controller: _editingController,
          decoration: InputDecoration.collapsed(hintText: ''),
        ),
      );
    return GestureDetector(
      onTap: () {
        setState(() {
          edited = true;
          isEditing = true;
        });
      },
      child: Text(
        initialText,
        style: edited
            ? AppStyle.activityTextStyle
            : AppStyle.txtPoppinsSemiBoldGray24,
      ),
    );
  }
}
