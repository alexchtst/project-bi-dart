import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({super.key, this.isNext = false, required this.onTap});

  final bool isNext;
  final VoidCallback onTap;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(3.0),
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.width * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.06,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 253, 159, 0),
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * 0.06,
            ),
          ),
          child: Icon(
            widget.isNext ? Icons.navigate_next : Icons.navigate_before,
            size: MediaQuery.of(context).size.width * 0.05,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
