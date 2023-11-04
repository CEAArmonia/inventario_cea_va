import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class PertenenciaPage extends ConsumerWidget {
  final String id;
  const PertenenciaPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertenencias'),
        leading: const Icon(LineIcons.objectGroup),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.print),
            onPressed: () {},
          )
        ],
      ),
      body: Center(child: Text(id)),
    );
  }
}
