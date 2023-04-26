import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happsales_crm/utils/color.dart';

class TagInputWidget extends StatefulWidget {
  @override
  _TagInputWidgetState createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInputWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter tags',
            ),
            onSubmitted: (value) {
              setState(() {
                _selectedTags.add(value);
                _textEditingController.clear();
              });
            },
          ),
          Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Text('Contacts',style: TextStyle(color: Colors.black),)),
          Wrap(
            spacing: 8,
            children: _buildTagChips(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTagChips() {
    return _selectedTags.map((tag) {
      final bool isSelected = _textEditingController.text.contains(tag);
      return GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              _textEditingController.text = _textEditingController.text.replaceAll(tag, '').trim();
            } else {
              _textEditingController.text += '${tag.trim()} ';
            }
          });
        },
        child: Chip(
          label: Text(tag),
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      );
    }).toList();
  }
}
