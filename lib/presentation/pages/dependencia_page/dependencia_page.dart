// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/presentation/pages/dependencia_page/widgets/add_depencia.dart';
import 'package:inventario_cea_va/presentation/providers/dependencia_provider.dart';
import 'package:line_icons/line_icons.dart';

class DependenciaPage extends ConsumerWidget {
  DependenciaPage({Key? key}) : super(key: key);

  final TextEditingController _tfDependenciaNombreController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List<Dependencia> listaDependencia = ref.watch(listaDependenciaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependencias'),
        leading: const Icon(LineIcons.school),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _tfDependenciaNombreController,
                decoration: InputDecoration(
                  icon: const Icon(LineIcons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(LineIcons.plusCircle),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddDependecia(),
                      );
                    },
                  ),
                  labelText: "Nombre de Dependencia",
                ),
                onChanged: (value) async {
                  DependenciaHelper dependenciaHelper = DependenciaHelper();
                  List<Dependencia> listaDependencias =
                      await dependenciaHelper.getDependencias(value);
                  ref
                      .read(listaDependenciaProvider.notifier)
                      .update((state) => listaDependencias);
                },
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listaDependencia.length,
                  itemBuilder: (context, index) {
                    Dependencia dependencia = listaDependencia[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        child: ListTile(
                          title: Text(dependencia.nombre),
                          subtitle: Text(dependencia.desc),
                          contentPadding: const EdgeInsets.only(left: 4),
                          leading: Icon(LineIcons.school),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
