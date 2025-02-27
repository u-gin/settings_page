import 'package:settings_page/util/exports.dart';


class ChechboxWithTextWidget extends StatefulWidget {
  late bool? initialValue;
  final String checkBoxMessage;

  ChechboxWithTextWidget(
      {Key? key, required this.checkBoxMessage, this.initialValue})
      : super(key: key);

  @override
  State<ChechboxWithTextWidget> createState() => _ChechboxWithTextWidgetState();
}

class _ChechboxWithTextWidgetState extends State<ChechboxWithTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: widget.initialValue,
          onChanged: (bool? value) {
            setState(() {
              widget.initialValue = value!;
            });
          },
        ),
        Text(
          widget.checkBoxMessage,
          style: AppStyle.txtPoppinsRegular14,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
