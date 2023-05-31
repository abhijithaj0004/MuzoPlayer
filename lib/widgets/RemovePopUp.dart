import 'package:flutter/material.dart';

class RemovePopUp extends StatelessWidget {
  VoidCallback onpressedClicked;

  RemovePopUp({super.key, required this.onpressedClicked});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: Text('PLEASE CONFIRM DELETION'),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: onpressedClicked,
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          label: Text(
                            'YES',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close_sharp,
                            color: Colors.red,
                          ),
                          label: Text(
                            'NO',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ))
                    ],
                  ),
                ],
              );
            }));
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: Text('Remove Song'),
            value: 0,
          ),
        ];
      },
    );
  }
}
