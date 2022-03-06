import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/model/api/profession_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class SpecialtyButton extends StatefulWidget {
  final ProfessionResult data;
  final int id;

  SpecialtyButton({
    required this.data,
    required this.id,
  });

  @override
  _SpecialtyButtonState createState() => _SpecialtyButtonState();
}

class _SpecialtyButtonState extends State<SpecialtyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 24,
      ),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.data.name,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
                color: AppTheme.black,
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 270),
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.purple),
            ),
            child: Center(
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.data.id == widget.id
                      ? AppTheme.orange
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}