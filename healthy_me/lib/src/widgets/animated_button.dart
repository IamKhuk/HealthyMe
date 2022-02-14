import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/model/api/region_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class AnimatedButton extends StatefulWidget {
  final RegionsResult data;
  final int id;

  AnimatedButton({
    required this.data,
    required this.id,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
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