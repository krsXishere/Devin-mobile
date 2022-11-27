import 'package:devin/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(children: [
        ListTile(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/information.svg",
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.title,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: _showContent
                ? SvgPicture.asset(
                    "assets/svg/caret-up.svg",
                    height: 30,
                    width: 30,
                  )
                : SvgPicture.asset(
                    "assets/svg/caret-down.svg",
                    height: 30,
                    width: 30 ,
                  ),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  widget.content,
                  style: primaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: regular,
                  ),
                ),
              )
            : Container()
      ]),
    );
  }
}
