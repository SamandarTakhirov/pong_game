import 'package:flutter/material.dart';

class PongMenu extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;

  const PongMenu({
    required this.subTitle,
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: size.height * 0.3,
        width: size.width * 0.6,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
