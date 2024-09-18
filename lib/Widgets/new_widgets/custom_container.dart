import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double elevation;
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? margin; // Optional margin
  final Color color; // Card color
  final BorderRadiusGeometry borderRadius; // Border radius
  final BoxShadow? boxShadow;
  // Box shadow for additional customization
  final void Function()? onTap;

  const CustomCard(
      {Key? key,
      this.elevation = 4.0, // Default elevation
      this.height,
      this.width,
      required this.child,
      this.margin,
      this.color = Colors.white, // Default color
      this.borderRadius = const BorderRadius.all(
          Radius.circular(12.0)), // Default border radius
      this.boxShadow,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null
            ? [boxShadow!]
            : [
                BoxShadow(
                    // color: Colors.black.withOpacity(0.2),
                    // blurRadius: elevation,
                    // spreadRadius: elevation / 2,
                    // offset: Offset(0, elevation / 2),
                    )
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: Theme.of(context).splashColor,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}
