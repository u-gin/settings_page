import 'package:settings_page/util/exports.dart';

class EditShippingAddressScreen extends StatefulWidget {
  @override
  State<EditShippingAddressScreen> createState() =>
      _EditShippingAddressScreenState();
}

class _EditShippingAddressScreenState extends State<EditShippingAddressScreen> {
  late TextEditingController countryController,
      regionController,
      cityController,
      addressController,
      additionalAddressController,
      landmarkController,
      suburbController,
      gpsController;

  String dropDownInitialValue = '';

  List<String> countries = [''];
  List<String> regions = [''];

  @override
  void initState() {
    countryController = TextEditingController();
    regionController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();
    additionalAddressController = TextEditingController();
    landmarkController = TextEditingController();
    suburbController = TextEditingController();
    gpsController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarWidgetNew(
            appBarTitle: "lbl_edit_shipping_addr".tr,
            trailingWidget: Icon(
              Icons.close,
            ),
            trailingWidgetFunction: () => Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    //"TODO: add map screen"
                  },
                  child: Container(
                    child: Row(
                      children: [
                        CommonImageView(
                          svgPath: 'assets/images/icon_mapp.svg',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "msg_find_address_on_map".tr.toUpperCase(),
                          style: AppStyle.poppinsTextstyle(
                            14.0,
                            FontWeight.w600,
                            Constants.lightBlue700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Text(
                  'lbl_country'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                DropDownFieldTemplate(
                  initialValue: dropDownInitialValue,
                  dropDownListItems: countries,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_region'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                DropDownFieldTemplate(
                  initialValue: dropDownInitialValue,
                  dropDownListItems: regions,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_city'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFieldTemplate(
                  controller: regionController,
                  hintText: '',
                  maxLines: 1,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_address'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFieldTemplate(
                  controller: addressController,
                  hintText: '',
                  maxLines: 1,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_additional_addr'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFieldTemplate(
                  controller: additionalAddressController,
                  hintText: 'Apartment, building, floor, etc.',
                  maxLines: 1,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_landmark'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFieldTemplate(
                  controller: landmarkController,
                  hintText: '',
                  maxLines: 1,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'lbl_suburb'.tr,
                  style: AppStyle.feedbackTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFieldTemplate(
                  controller: suburbController,
                  hintText: '',
                  maxLines: 1,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'lbl_gps_addr'.tr,
                            style: AppStyle.feedbackTextStyle,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextFieldTemplate(
                            controller: gpsController,
                            hintText: 'GZ-183-7623',
                            maxLines: 1,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 24.0,
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                Button(
                  text: "SAVE",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
