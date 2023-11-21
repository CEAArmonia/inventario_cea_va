// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/responsable_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class DialogResponsable extends ConsumerWidget {
  Item item;
  DialogResponsable(this.item, {super.key});

  TextEditingController tfNombreEncargado = TextEditingController();
  TextEditingController tfCiEncargado = TextEditingController();
  TextEditingController tfCargoEncargado = TextEditingController();
  TextEditingController tfTelefonoEncargado = TextEditingController();
  TextEditingController tfCantidadAsignacion = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    tfNombreEncargado.text = ref.watch(nombreAsignacionProvider);
    tfCiEncargado.text = ref.watch(cedulaAsignacionProvider);
    tfCargoEncargado.text = ref.watch(cargoAsignacionProvider);
    tfTelefonoEncargado.text = ref.watch(telefonoAsignacionProvider);
    tfCantidadAsignacion.text = ref.watch(cantidadAsignacionProvider);

    return AlertDialog(
      backgroundColor: AppTheme.secondaryColor,
      icon: const Icon(
        LineIcons.alternateStore,
        size: 40,
      ),
      shadowColor: AppTheme.shadowColor,
      iconColor: AppTheme.shadowColor,
      title: Text(
        'Asignación',
        style: GoogleFonts.lilitaOne(
          color: AppTheme.shadowColor,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SizedBox(
        height: size.height * .35,
        width: size.width * .8,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tfCiEncargado,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        icon: Icon(
                          LineIcons.identificationCard,
                        ),
                        labelText: "Cédula de Identidad",
                      ),
                      onChanged: (value) async {
                        ResponsableHelper helper = ResponsableHelper();
                        if (value != '') {
                          ref.read(listaResponsableProvider.notifier).state =
                              await helper.getResponsablesPorCi(value);
                        } else {
                          ref.read(listaResponsableProvider.notifier).state =
                              await helper.getResponsables();
                        }
                      },
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return ref
                          .watch(listaResponsableProvider)
                          .map((responsable) => PopupMenuItem<String>(
                              value: responsable.id,
                              child: Text(responsable.ci)))
                          .toList();
                    },
                    onSelected: (value) {
                      Responsable responsable = ref
                          .watch(listaResponsableProvider)
                          .firstWhere((element) => element.id == value);
                      ref.read(nombreAsignacionProvider.notifier).state =
                          responsable.nombre;
                      ref.read(cedulaAsignacionProvider.notifier).state =
                          responsable.ci;
                      ref.read(cargoAsignacionProvider.notifier).state =
                          responsable.cargo;
                      ref.read(telefonoAsignacionProvider.notifier).state =
                          responsable.telefono;
                    },
                  ),
                ],
              ),
              TextField(
                controller: tfNombreEncargado,
                decoration: const InputDecoration(
                  icon: Icon(
                    LineIcons.userAlt,
                  ),
                  labelText: "Nombre del encargado",
                ),
              ),
              TextField(
                controller: tfCargoEncargado,
                decoration: const InputDecoration(
                  icon: Icon(
                    LineIcons.userGraduate,
                  ),
                  labelText: "Cargo o Responsabilidad",
                ),
              ),
              TextField(
                controller: tfTelefonoEncargado,
                decoration: const InputDecoration(
                  icon: Icon(
                    LineIcons.phone,
                  ),
                  labelText: "Teléfono del encargado",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: tfCantidadAsignacion,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          int? numero = int.tryParse(value);
                          if (numero != null && numero > 0) {
                            ref
                                .read(cantidadAsignacionProvider.notifier)
                                .state = value;
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          LineIcons.sortNumericUp,
                        ),
                        labelText: "Cantidad",
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      LineIcons.plusCircle,
                      size: 25,
                    ),
                    onPressed: () {
                      if (tfCantidadAsignacion.text.isNotEmpty) {
                        int cantidad = int.parse(tfCantidadAsignacion.text);
                        ref
                            .read(cantidadAsignacionProvider.notifier)
                            .update((state) {
                          cantidad += 1;
                          return '$cantidad';
                        });
                      } else {
                        int cantidad = 0;
                        ref
                            .read(cantidadAsignacionProvider.notifier)
                            .update((state) => '$cantidad');
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      LineIcons.minusCircle,
                      size: 25,
                    ),
                    onPressed: () {
                      if (tfCantidadAsignacion.text.isNotEmpty) {
                        if (int.parse(tfCantidadAsignacion.text) > 0) {
                          int cantidad = int.parse(tfCantidadAsignacion.text);
                          ref
                              .read(cantidadAsignacionProvider.notifier)
                              .update((state) {
                            cantidad -= 1;
                            return '$cantidad';
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text('Aceptar'),
                    onPressed: () async {
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        ResponsableHelper helper = ResponsableHelper();
                        if (validarVacios()) {
                          int cantidad = int.parse(tfCantidadAsignacion.text);
                          bool asignado = await helper.asignarItemResponsable(
                            tfCiEncargado.text,
                            tfNombreEncargado.text,
                            tfCargoEncargado.text,
                            item.id,
                            tfTelefonoEncargado.text,
                            cantidad,
                          );
                          if (asignado) {
                            ref.invalidate(nombreAsignacionProvider);
                            ref.invalidate(cedulaAsignacionProvider);
                            ref.invalidate(cargoAsignacionProvider);
                            ref.invalidate(telefonoAsignacionProvider);
                            ref.invalidate(cantidadAsignacionProvider);
                            ref.read(listaItemsProvider.notifier).update((state) {
                              Item itemEncontrado = state.firstWhere((element) => element.id == item.id);
                              itemEncontrado.cantidad = itemEncontrado.cantidad - cantidad;
                              return state;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item asignado correctamente'),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error en la asignación'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Campos de texto vacíos!!!'),
                            ),
                          );
                        }
                      } else {
                        GlobalFunctions.logoutUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      ref.invalidate(nombreAsignacionProvider);
                      ref.invalidate(cedulaAsignacionProvider);
                      ref.invalidate(cargoAsignacionProvider);
                      ref.invalidate(telefonoAsignacionProvider);
                      ref.invalidate(cantidadAsignacionProvider);
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validarVacios() {
    if (tfNombreEncargado.text.isNotEmpty &&
        tfCiEncargado.text.isNotEmpty &&
        tfCargoEncargado.text.isNotEmpty &&
        tfTelefonoEncargado.text.isNotEmpty &&
        tfCantidadAsignacion.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
