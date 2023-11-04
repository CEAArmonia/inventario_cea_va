// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/models/user.dart';
import 'package:inventario_cea_va/presentation/pages/pages.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class ItemPage extends ConsumerWidget {
  ItemPage({Key? key}) : super(key: key);

  DateTime? fechaCompra;
  String itemName = '';
  String itemDesc = '';
  String itemObs = '';
  String itemLocation = '';
  double itemValue = 0;
  int itemLife = 0;
  int itemMaintenance = 0;
  int itemQuantity = 0;
  int conditions = 0;

  final TextEditingController _tfNombreController = TextEditingController();
  final TextEditingController _tfDescController = TextEditingController();
  final TextEditingController _tfValorController = TextEditingController();
  final TextEditingController _tfUbicacionController = TextEditingController();
  final TextEditingController _tfObservacionesController =
      TextEditingController();
  final TextEditingController _tfTiempoVidaController = TextEditingController();
  final TextEditingController _tfLapsoController = TextEditingController();
  final TextEditingController _tfCantidadController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(fechaActualProvider);
    final dropdownEstadoValue = ref.watch(dropdownEstadoValueProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          LineIcons.boxes,
          size: 35,
        ),
        title: const Text(
          'Registro de Items',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _tfNombreController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              cursorColor: AppTheme.brightColor,
              decoration: const InputDecoration(
                labelText: "Nombre de Item",
                icon: Icon(
                  LineIcons.boxOpen,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .015,
            ),
            TextField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              controller: _tfDescController,
              cursorColor: AppTheme.brightColor,
              decoration: const InputDecoration(
                labelText: "Descripción de Item",
                icon: Icon(
                  LineIcons.alternateFile,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .015,
            ),
            TextField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              controller: _tfObservacionesController,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: AppTheme.brightColor,
              decoration: const InputDecoration(
                labelText: "Observaciones de Item",
                icon: Icon(
                  LineIcons.pencilRuler,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .015,
            ),
            TextField(
              controller: _tfUbicacionController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: AppTheme.brightColor,
              decoration: const InputDecoration(
                labelText: "Ubicación del Item",
                icon: Icon(LineIcons.mapMarker),
              ),
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .40,
                  child: TextField(
                    controller: _tfValorController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.brightColor,
                    decoration: const InputDecoration(
                      labelText: 'Costo (bs.)',
                      icon: Icon(
                        LineIcons.moneyBill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .40,
                  child: TextField(
                    controller: _tfTiempoVidaController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.brightColor,
                    decoration: const InputDecoration(
                      labelText: 'Tiempo Vida (años)',
                      icon: Icon(LineIcons.clockAlt),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .40,
                  child: TextField(
                    controller: _tfLapsoController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.brightColor,
                    decoration: const InputDecoration(
                      icon: Icon(LineIcons.alternateCalendar),
                      label: Text('Mantenimiento (meses)'),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .40,
                  child: TextField(
                    controller: _tfCantidadController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.brightColor,
                    decoration: const InputDecoration(
                      icon: Icon(LineIcons.alternateSortNumericUp),
                      label: Text('Cantidad'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .6,
                  child: const Center(
                    child: DropdownTipoItem(),
                  ),
                ),
                SizedBox(
                  width: size.width * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(LineIcons.plusCircle),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => BottomSheetAddTipoItem(),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(LineIcons.minusCircle),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                const BottomSheetSubtractTipoItem(),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text(
                    'Fecha de compra: $date',
                  ),
                  onPressed: () {
                    DateTimePicker().selectDate(context, ref);
                  },
                ),
                DropdownButton(
                  value: dropdownEstadoValue,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: AppTheme.shadowColor,
                    fontWeight: FontWeight.bold,
                  ),
                  hint: const Text(
                    'Estado',
                  ),
                  iconDisabledColor: AppTheme.primaryColor,
                  iconEnabledColor: AppTheme.shadowColor,
                  dropdownColor: AppTheme.secondaryColor,
                  onChanged: (value) {
                    ref
                        .read(dropdownEstadoValueProvider.notifier)
                        .update((state) => value);
                    itemState = value!;
                  },
                  items: <String>['Activo', 'Inactivo'].map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            SizedBox(
              height: size.height * .015,
            ),
            ElevatedButton.icon(
              icon: const Icon(LineIcons.save),
              label: const Text('Guardar Item'),
              onPressed: () async {
                ItemHelper helper = ItemHelper();
                DateTime buyDate = GlobalFunctions.stringToDate(
                    ref.watch(fechaActualProvider));
                if (_tfNombreController.text.isEmpty ||
                    _tfNombreController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Nombre de Item vacío.'),
                    ),
                  );
                } else {
                  itemName = _tfNombreController.text;
                  conditions++;
                }
                if (_tfDescController.text.isEmpty ||
                    _tfDescController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Descripción de Item vacío.'),
                    ),
                  );
                } else {
                  itemDesc = _tfDescController.text;
                  conditions++;
                }
                if (_tfObservacionesController.text.isEmpty ||
                    _tfObservacionesController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Observaciones de Item vacío.'),
                    ),
                  );
                } else {
                  itemObs = _tfObservacionesController.text;
                  conditions++;
                }
                if (_tfUbicacionController.text.isEmpty ||
                    _tfUbicacionController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Ubicación de Item vacío.'),
                    ),
                  );
                } else {
                  itemLocation = _tfUbicacionController.text;
                  conditions++;
                }
                if (_tfValorController.text.isEmpty ||
                    _tfValorController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Costo de Item vacío.'),
                    ),
                  );
                } else {
                  itemValue = double.parse(_tfValorController.text);
                  conditions++;
                }
                if (_tfTiempoVidaController.text.isEmpty ||
                    _tfTiempoVidaController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Tiempo de Vida de Item vacío.'),
                    ),
                  );
                } else {
                  itemLife = int.parse(_tfTiempoVidaController.text);
                  conditions++;
                }
                if (_tfLapsoController.text.isEmpty ||
                    _tfLapsoController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Mantenimiento de Item vacío.'),
                    ),
                  );
                } else {
                  itemMaintenance = int.parse(_tfLapsoController.text);
                  conditions++;
                }
                if (_tfCantidadController.text.isEmpty ||
                    _tfCantidadController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Descripción de Item vacío.'),
                    ),
                  );
                } else {
                  itemQuantity = int.parse(_tfCantidadController.text);
                  conditions++;
                }
                if (itemState == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Estado de Item vacío.'),
                    ),
                  );
                } else {
                  conditions++;
                }
                if (itemType == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Campo Tipo de Item vacío.'),
                    ),
                  );
                } else {
                  conditions++;
                }
                if (conditions >= 8) {
                  if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                    showDialog(
                      context: context,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    );
                    Item newItem = await helper.addItem(
                      itemName,
                      itemDesc,
                      itemObs,
                      itemLocation,
                      itemValue,
                      itemLife,
                      itemMaintenance,
                      itemQuantity,
                      itemState,
                      itemType,
                      buyDate,
                    );
                    conditions = 0;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item agregado.'),
                      ),
                    );
                    List<Item> lista = await helper.getItems();
                    lista.add(newItem);
                    lista.sort(
                      (a, b) => a.nombre.compareTo(b.nombre),
                    );
                    //Método para agregar las fechas de mantenimientos al item agregado
                    helper.assignMaintenance(newItem.fechaCompra,
                        itemMaintenance, itemLife, newItem.id);
                    ref
                        .read(listaItemsProvider.notifier)
                        .update((state) => lista);
                    vaciarElementos(
                      _tfNombreController,
                      _tfDescController,
                      _tfValorController,
                      _tfUbicacionController,
                      _tfObservacionesController,
                      _tfTiempoVidaController,
                      _tfLapsoController,
                      _tfCantidadController,
                      ref,
                    );
                    Navigator.pop(context);
                  } else {
                    jwtUsuarioConectado = '';
                    usuarioLogueado = User(
                      id: 'id',
                      nombre: 'nombre',
                      telefono: 'telefono',
                      ci: 'ci',
                    );
                    Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                  }
                } else {
                  conditions = 0;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void vaciarElementos(
      TextEditingController tfNombreController,
      TextEditingController tfDescController,
      TextEditingController tfValorController,
      TextEditingController tfUbicacionController,
      TextEditingController tfObservacionesController,
      TextEditingController tfTiempoVidaController,
      TextEditingController tfLapsoController,
      TextEditingController tfCantidadController,
      WidgetRef ref) {
    tfNombreController.clear();
    tfDescController.clear();
    tfValorController.clear();
    tfUbicacionController.clear();
    tfObservacionesController.clear();
    tfTiempoVidaController.clear();
    tfLapsoController.clear();
    tfCantidadController.clear();
    ref.invalidate(tiposItemProvider);
    ref.invalidate(fechaActualProvider);
    ref.invalidate(dropdownEstadoValueProvider);
  }
}
