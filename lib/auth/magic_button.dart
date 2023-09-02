import 'package:flutter/material.dart';

class MagicButton extends StatelessWidget {
  const MagicButton({
    Key? key,
    required this.password,
    required this.email,
    required this.text,
  }) : super(key: key);

  final String email, password, text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: 60,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 18,
            child: Container(
              width: size.width * 0.88,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.pinkAccent[700]!,
                  width: 1.25,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 04,
            left: 8,
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.88,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepOrange[400]!,
                    Colors.pink.shade600,
                  ],
                ),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
