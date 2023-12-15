import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ticTactoe extends StatefulWidget {
  const ticTactoe({super.key});

  @override
  State<ticTactoe> createState() => _ticTactoeState();
}

// ignore: camel_case_types
enum player { x, o }

// ignore: camel_case_types
class _ticTactoeState extends State<ticTactoe> {
  player current = player.o;
  var items = <player?>[
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];
  int counter = 0;
  // ignore: non_constant_identifier_names
  player? Winnner;
  bool endgame = false;
  checkwinner() {
    const winnercase = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var element in winnercase) {
      // ignore: non_constant_identifier_names
      final Fitem = items[element[0]];
      // ignore: non_constant_identifier_names
      final Sitem = items[element[1]];
      // ignore: non_constant_identifier_names
      final Titem = items[element[2]];
      if (Fitem == Sitem && Sitem == Titem && Fitem != null) {
        Winnner = Fitem;
        endgame = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "current player is ${current.name}",
                  style: const TextStyle(fontSize: 25),
                ),
                Board(
                  items: items,
                  onClick: (i) {
                    if (endgame == true) return;
                    if (counter == 9 && Winnner == null) {
                      endgame = true;
                    }

                    if (items[i] != null) {
                      //  ScaffoldMessenger.of(context).showSnackBar(
                      //  const SnackBar(content: Text("pls select empty location")));
                      return;
                    }
                    setState(() {
                      counter++;
                      items[i] = current;
                      current = current == player.o ? player.x : player.o;
                      checkwinner();
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                if (Winnner != null)
                  Text(
                    "the winner is ${Winnner!.name}",
                    style: const TextStyle(fontSize: 25),
                  ),
                if (counter == 9 && Winnner == null)
                  const Text(
                    "it's Draw",
                    style: TextStyle(fontSize: 30),
                  ),
                if (counter == 9 || Winnner != null)
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        endgame = false;
                        items = List.filled(9, null);
                        Winnner = null;
                        counter = 0;
                        current = player.x;
                      });
                    },
                    height: 50,
                    color: Colors.green,
                    minWidth: 200,
                    child: const Text("Retry"),
                  ),
              ],
            )),
      ),
    );
  }
}

class Board extends StatelessWidget {
  final List<player?> items;
  final void Function(int)
      onClick; // Adjusted the syntax for the function definition
  const Board({Key? key, required this.items, required this.onClick})
      : super(
            key: key); // Call the superclass constructor with the provided key

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
      children: [
        for (int i = 0; i < items.length; i++)
          InkWell(
            onTap: () {
              onClick(i);
            },
            child: Container(
              color: Colors.blue,
              child: BordItem(item: items[i]),
            ),
          )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('onClick', onClick));
  }
}

class BordItem extends StatelessWidget {
  final player? item;
  const BordItem({Key? key, this.item})
      : super(
            key: key); // Call the superclass constructor with the provided key

  @override
  Widget build(BuildContext context) {
    if (item == null) return const SizedBox();
    return Center(
      child: Text(
        item!.name,
        style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
      ),
    );
  }
}
