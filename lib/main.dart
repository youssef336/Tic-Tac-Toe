import 'package:flutter/widgets.dart';
import 'package:youtube/tic.dart';

void main() {
  runApp(const game());
}
// ignore: camel_case_types
class game extends StatelessWidget {
  const game({super.key});

  @override
  Widget build(BuildContext context) {
    return   const ticTactoe();
  }
}
