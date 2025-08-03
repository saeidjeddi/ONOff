import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';








myLaunchUrl(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    log("could not launch ${uri.toString()}");
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20,
      ),
    );
  }
}







Widget buildPlatformRow(String imagePath, String url) {
  return Row(
    children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: AssetImage(imagePath)),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (url.isNotEmpty && url != 'No URL') {
              myLaunchUrl(url);
            }
          },
          child: Text(
            url,
            style: TextStyle(
              color: url.startsWith('http') ? Colors.blue : Colors.grey,
              decoration: url.startsWith('http') 
                  ? TextDecoration.underline 
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    ],
  );
}