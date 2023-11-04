import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/presentation/pages/pages.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class BottomSheetSubtractTipoItem extends ConsumerWidget {
  const BottomSheetSubtractTipoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final listaTipos = ref.watch(tiposItemProvider);

    return Container(
      height: size.height * .5,
      decoration: const BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Eliminar Tipo de Item",
              style: GoogleFonts.lilitaOne(
                fontSize: 15,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaTipos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    shadowColor: AppTheme.shadowColor,
                    child: ListTile(
                      leading: const Icon(
                        LineIcons.box,
                        color: AppTheme.primaryColor,
                      ),
                      title: Text(
                        listaTipos[index].nombre,
                        style: GoogleFonts.lato(
                            color: AppTheme.shadowColor,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          LineIcons.alternateTrash,
                          color: AppTheme.brightColor,
                        ),
                        onPressed: () {
                          Icon icon = const Icon(
                            LineIcons.trash,
                            color: AppTheme.shadowColor,
                          );
                          Text title = const Text('Eliminar');
                          Text content = Text(
                              "¿Está seguro que desea eliminar el tipo de item ${listaTipos[index].nombre}?");
                          showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialogItem(icon, title, content, listaTipos[index]),
                          );
                          //
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
