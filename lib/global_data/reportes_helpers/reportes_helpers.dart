// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportesHelper {
  Future<File> reportePertenencias(
      Dependencia dependencia, List<Pertenece> pertenencias) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        pageFormat: PdfPageFormat.letter,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text(
                  'Reporte de Pertenencias',
                  style: const pw.TextStyle(
                    fontSize: 25,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Dependencia: ${dependencia.nombre}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Descipción: ${dependencia.desc}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      )
                    ]),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.SizedBox(
                      width: 165,
                      child: pw.Text(
                        'Item',
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.SizedBox(width: 17),
                    pw.SizedBox(
                      width: 65,
                      child: pw.Text(
                        'Fecha',
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.SizedBox(width: 17),
                    pw.SizedBox(
                      width: 35,
                      child: pw.Text(
                        'Cant.',
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.SizedBox(width: 17),
                    pw.SizedBox(
                      width: 95,
                      child: pw.Text(
                        'Retorno',
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                    pw.SizedBox(width: 17),
                    pw.SizedBox(
                      width: 70,
                      child: pw.Text(
                        'Fecha Retorno',
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ],
                ),
                pw.ListView.separated(
                  itemCount: pertenencias.length,
                  separatorBuilder: (context, index) => pw.SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (context, index) {
                    Pertenece pertenencia = pertenencias[index];
                    return pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 165,
                          child: pw.Text(pertenencia.item.nombre),
                        ),
                        pw.SizedBox(width: 17),
                        pw.SizedBox(
                          width: 65,
                          child: pw.Text(
                              GlobalFunctions.dateToString(pertenencia.fecha)),
                        ),
                        pw.SizedBox(width: 17),
                        pw.SizedBox(
                          width: 35,
                          child: pw.Text(
                            pertenencia.cantidad.toString(),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.SizedBox(width: 17),
                        pw.SizedBox(
                          width: 95,
                          child: pw.Text(
                            pertenencia.retornado ? 'Devuelto' : 'En Poseción',
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.SizedBox(width: 17),
                        pw.Text(
                          pertenencia.fechaRetorno!.isAfter(DateTime(1900))
                              ? GlobalFunctions.dateToString(
                                  pertenencia.fechaRetorno!)
                              : '',
                          textAlign: pw.TextAlign.center,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );

    DateTime fecha = DateTime.now();
    String fechaParseada = GlobalFunctions.dateToString(fecha);
    final systemDocsDir = await getApplicationDocumentsDirectory();
    final pdfPath =
        '${systemDocsDir.path}/reporte_pertenencias$fechaParseada.pdf';
    final file = File(pdfPath);
    file.writeAsBytesSync(await pdf.save());
    return file;
  }

  Future<File> reporteBitacorasAcceso(
      User? usuarioSeleccionado, List<Bitacora> listaBitacoras) async {
    if (usuarioSeleccionado != null) {
      var pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          pageFormat: PdfPageFormat.letter,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Reporte Bitacoras',
                    style: const pw.TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Nombre completo: ${usuarioSeleccionado.nombre}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Cédula de Identidad: ${usuarioSeleccionado.ci}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      )
                    ],
                  ),
                  pw.SizedBox(height: 15),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Telefono: ${usuarioSeleccionado.telefono}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      usuarioSeleccionado.administrador
                          ? pw.Text(
                              'Es administrador: Sí',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            )
                          : pw.Text(
                              'Es administrador: No',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            )
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Fecha de Ingreso',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      pw.Text(
                        'Nombre de Cuenta',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  pw.ListView.builder(
                    itemCount: listaBitacoras.length,
                    /* separatorBuilder: (context, index) =>
                        pw.SizedBox(height: 25), */
                    itemBuilder: (context, index) {
                      return pw.Column(children: [
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text(GlobalFunctions.dateToString(
                                listaBitacoras[index].fecha)),
                            pw.Text(usuarioSeleccionado.nombre)
                          ],
                        ),
                        pw.SizedBox(height: 5),
                      ]);
                    },
                  )
                ],
              ),
            );
          },
        ),
      );
      DateTime fecha = DateTime.now();
      String fechaParseada = GlobalFunctions.dateToString(fecha);
      final systemDocsDir = await getApplicationDocumentsDirectory();
      final pdfPath =
          '${systemDocsDir.path}/reporte_pertenencias$fechaParseada.pdf';
      final file = File(pdfPath);
      file.writeAsBytesSync(await pdf.save());
      return file;
    } else {
      var pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          pageFormat: PdfPageFormat.letter,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Reporte Bitacoras',
                    style: const pw.TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Fecha de Ingreso',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      pw.Text(
                        'Nombre de Cuenta',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  pw.ListView.builder(
                    itemCount: listaBitacoras.length,
                    /* separatorBuilder: (context, index) =>
                        pw.SizedBox(height: 10), */
                    itemBuilder: (context, index) {
                      return pw.Column(children: [
                        pw.SizedBox(height: 5),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text(
                              GlobalFunctions.dateToString(
                                  listaBitacoras[index].fecha),
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Text(
                              listaBitacoras[index].usuario!.nombre,
                              style: const pw.TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        pw.SizedBox(height: 5)
                      ]);
                    },
                  )
                ],
              ),
            );
          },
        ),
      );
      DateTime fecha = DateTime.now();
      String fechaParseada = GlobalFunctions.dateToString(fecha);
      final systemDocsDir = await getApplicationDocumentsDirectory();
      final pdfPath =
          '${systemDocsDir.path}/reporte_pertenencias$fechaParseada.pdf';
      final file = File(pdfPath);
      file.writeAsBytesSync(await pdf.save());
      return file;
    }
  }

  Future<File> reporteCantidades(List<Item> listaItems) async {
    var pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Cantidades bajas en Items',
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text('Nombre de Producto',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Fecha de Compra',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Cantidad Disponible',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.ListView.builder(
                  itemCount: listaItems.length,
                  itemBuilder: (context, index) {
                    return pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text(listaItems[index].nombre,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text(
                                GlobalFunctions.dateToString(
                                    listaItems[index].fechaCompra),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text('${listaItems[index].cantidad}',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
    DateTime fecha = DateTime.now();
    String fechaParseada = GlobalFunctions.dateToString(fecha);
    final systemDocsDir = await getApplicationDocumentsDirectory();
    final pdfPath =
        '${systemDocsDir.path}/reporte_cantidades$fechaParseada.pdf';
    final file = File(pdfPath);
    file.writeAsBytesSync(await pdf.save());
    return file;
  }

  Future<File> reporteInventario(List<Item> itemsReporte) async {
    var pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  'Reporte Inventario',
                  style: const pw.TextStyle(fontSize: 20),
                ),
                pw.SizedBox(height: 25),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Nombre',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Fecha Compra',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Cantidad',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Precio',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    )
                  ],
                ),
                pw.SizedBox(height: 15),
                pw.ListView.builder(
                  itemCount: itemsReporte.length,
                  itemBuilder: (context, index) {
                    final item = itemsReporte[index];
                    return pw.Column(
                      children: [
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.SizedBox(
                              width: 150,
                              child: pw.Expanded(
                                child: pw.Text(item.nombre),
                              ),
                            ),
                            pw.SizedBox(
                              width: 140,
                              child: pw.Text(
                                  GlobalFunctions.dateToString(
                                      item.fechaCompra),
                                  textAlign: pw.TextAlign.center),
                            ),
                            pw.SizedBox(width: 80),
                            pw.SizedBox(
                              width: 70,
                              child: pw.Text('${item.cantidad}'),
                            ),
                            pw.SizedBox(width: 75),
                            pw.SizedBox(
                              width: 70,
                              child: pw.Text('${item.valor}'),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 10)
                      ],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );

    DateTime fecha = DateTime.now();
    String fechaParseada = GlobalFunctions.dateToString(fecha);
    final systemDocsDir = await getApplicationDocumentsDirectory();
    final pdfPath =
        '${systemDocsDir.path}/reporte_pertenencias$fechaParseada.pdf';
    final file = File(pdfPath);
    file.writeAsBytesSync(await pdf.save());
    return file;
  }
}
