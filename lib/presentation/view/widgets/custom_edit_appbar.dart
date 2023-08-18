
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget /*implements PreferredSizeWidget*/ {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onTick;

  CustomAppBar({
    required this.title,
    this.onBack,
    this.onTick,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: onBack,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
      ),
      /*actions: [
        if (onTick != null)
          IconButton(
            icon: Icon(Icons.check,color: Colors.white),
            onPressed: onTick,
          ),
      ],*/
      centerTitle: true,
    );
  }

  /*@override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);*/
}
