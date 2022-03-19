import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

Widget popupdescription(var context, var nom, var image, var description) {
  return Material(
    child: InkWell(
      onTap: () {
        CoolAlert.show(
            context: context,
            widget: Container(
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Text(nom)),
                Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: CircularProfileAvatar(
                      '',
                      child: Image.network(image),
                      borderColor: Color.fromARGB(255, 48, 118, 146),
                      borderWidth: 1,
                      elevation: 2,
                      radius: 50,
                      imageFit: BoxFit.fill,
                    )),
                Text(description),
              ]),
            ),
            type: CoolAlertType.custom,
            confirmBtnColor: Color.fromARGB(255, 48, 118, 146),
            backgroundColor: Color.fromARGB(255, 48, 118, 146));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.network(image),
      ),
    ),
  );
}
