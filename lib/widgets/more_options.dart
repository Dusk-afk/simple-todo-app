import 'package:flutter/material.dart';

class MoreOptions extends StatelessWidget {
  final Function delete;
  final Function edit;

  const MoreOptions({ Key? key, required this.delete, required this.edit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Button(
                onPressed: () {
                  Navigator.pop(context);
                  edit();
                },
                text: "Edit",
                destructive: false,
              ),
              SizedBox(height: 5,),
              _Button(
                onPressed: () {
                  Navigator.pop(context);
                  delete();
                },
                text: "Delete",
                destructive: true,
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Function onPressed;
  final bool destructive;
  final String text;

  const _Button({ Key? key, required this.onPressed, this.destructive = false, required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      // pressedOpacity: 0.9,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Color.fromARGB(20, 255, 255, 255)),
        backgroundColor: MaterialStateProperty.all(destructive? Colors.red : Colors.blue),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15))
      ),
    );
  }
}