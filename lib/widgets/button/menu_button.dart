import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.primary = false,
  });

  final IconData icon;
  final bool primary;
  final VoidCallback? onPressed;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: widget.onPressed,
      child: Container(
        padding: !widget.primary ? EdgeInsets.all(5.0) : EdgeInsets.all(8.0),
        width:
            !widget.primary
                ? MediaQuery.of(context).size.width * 0.07
                : MediaQuery.of(context).size.width * 0.1,
        height:
            !widget.primary
                ? MediaQuery.of(context).size.width * 0.07
                : MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 253, 159, 0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: !widget.primary ? EdgeInsets.all(8.0) : EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 217, 53),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Icon(
            widget.icon,
            size: !widget.primary ? 25.0 : 40.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
