// file for all contacts regarding this organization and the development team for this app

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key});
  final universalTextStyle = const TextStyle(color: Colors.white, fontSize: 20);
  final String phoneNumber = '+7(xxx)xxx-xx-xx'; // TODO: Заполнить эти поля
  final String address = "​Посёлок Аякс, xx, Владивостокский городской округ, Приморский край,\nКорпус X, кабинет xxx.\nИндекс: 690xxx.";

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Контакты СПНР:', style: TextStyle(fontSize: 25 ,color: Colors.white)), // TODO: check if the scaling is off on ALL devices
        ),
        Divider(
          thickness: 3,
          height: 3,
          color: Colors.grey
        ),
        Container(
          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Телефон: $phoneNumber', style: universalTextStyle,),
              Text('Адрес: $address', style: universalTextStyle,),
              Link(
                uri: Uri.parse('http://localhost:5150'), // TODO: change to actual website
                builder: (context, followLink) {
                  return RichText(
                    text: TextSpan(
                      text: 'Веб-сайт СПНР.',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20),
                      recognizer: TapGestureRecognizer()..onTap = followLink, 
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(
          thickness: 3,
          height: 3,
          color: Colors.grey
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 15.0),
          color: Color.fromRGBO(33, 37, 41, 1),
          child: Text('Контакты разработчиков:', style: TextStyle(fontSize: 25 ,color: Colors.white)), // TODO: check if the scaling is off on ALL devices
        ),
        Divider(
          thickness: 3,
          height: 3,
          color: Colors.grey
        ),
        Container(
          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Link(
                uri: Uri.parse('https://github.com/SPNRDevTeam/info_SPNR'),
                builder: (context, followLink) {
                  return Row(
                    children: [
                      Icon(FontAwesomeIcons.github),
                      Text(' '),
                      RichText(
                        text: TextSpan(
                          text: 'GitHub репозиторий',
                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20),
                          recognizer: TapGestureRecognizer()..onTap = followLink, 
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}