import 'package:flutter/material.dart';

class SeverityImage extends StatelessWidget {

  final Size size;
  final String severity;
  
  const SeverityImage({
    Key? key,
    required this.size, 
    required this.severity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        child: Image(image: setImage(severity),fit: BoxFit.cover,),
        height: size.height*0.1,
        width: size.height*0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)
        ),
      ),
    );
  }
}

AssetImage setImage(String severity){
    if (severity == 'severe') {
      return const AssetImage('assets/status_icons/Red-Status-Icon.png');
    }
    else if (severity == 'elevated') {
      return const AssetImage('assets/status_icons/Blue-Status-Icon.png');
    }
    else if (severity == 'high') {
      return const AssetImage('assets/status_icons/Orange-Status-Icon.png');
    }
    else {
      return const AssetImage('assets/status_icons/Green-Status-Icon1.png');
    }
  }