import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:muzo/widgets/RemovePopUp.dart';


class TopBeats extends StatelessWidget {
  void _showConfirmationDialog(BuildContext context, Function onConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PLEASE CONFIRM DELETION'),
          actions: [
            TextButton.icon(
              onPressed: () {
                onConfirmed();
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
              label: Text('YES'),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              label: Text('NO'),
            ),
          ],
        );
      },
    );
  }

  const TopBeats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 108, 99, 255),
                Color.fromARGB(79, 107, 99, 255),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(400))),
        ),
        Positioned(
          top: 50,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 100,
              ),
              const Text(
                'TOPBEATS',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'KumbhSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 100, right: 20),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 90,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 203, 203, 203),
                        Color.fromARGB(0, 207, 207, 207),
                      ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/filip-5LhSaUDgtZ8-unsplash.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Heat-Waves....',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'KumbhSans'),
                        ),
                      ),
                      trailing: RemovePopUp(onpressedClicked: (){},),
                    ),
                  ));
            },
            itemCount: 3,
          ),
        )
      ]),
    );
  }
}


