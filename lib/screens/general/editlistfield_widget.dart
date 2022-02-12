import 'package:flutter/material.dart';

class EditListFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final List<String> editList;
  final ValueChanged<String> onChanged;

  const EditListFieldWidget({
    Key key,
    this.maxLines = 1,
    @required this.label,
    @required this.text,
    @required this.onChanged,
    @required this.editList,
  }) : super(key: key);

  @override
  _EditListFieldWidgetState createState() => _EditListFieldWidgetState();
}

class _EditListFieldWidgetState extends State<EditListFieldWidget> {

  TextEditingController controller;
  List<String> currentList;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
    currentList = (widget.editList);

  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Input Here, Press Enter to Save',
          hintStyle: TextStyle(fontSize: 11),
        ),
        maxLines: widget.maxLines,
        onSubmitted: (value){
          setState(() {
            currentList.add(value);
          });
          controller.text = "";
        },
        textInputAction: TextInputAction.go,
      ),
      Wrap(
        children: List<Widget>.generate(
          currentList.length,
              (index) => itemChip(context, currentList[index], index),
        ),
      )

    ],
  );


  Widget itemChip (BuildContext context, String itemValue, int index) => InputChip(
    label: Text(
      itemValue,
      overflow: TextOverflow.ellipsis,
    ),
    onDeleted: (){
      setState(() {
        currentList.removeAt(index);
      });
    },
  );

}