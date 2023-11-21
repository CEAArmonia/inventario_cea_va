import 'models_reportes.dart';

List<ReporteModel> listaReportes = [
  ReporteModel(
      nombre: 'Bitacora',
      desc: 'Reporte de los Ingresos al sistema de todos los usuarios',
      opcion: 'bitacora'),
  ReporteModel(
      nombre: 'Cantidades bajas',
      desc: 'Reporte de los Items con cantidades bajas',
      opcion: 'cant_bajas'),
  ReporteModel(
      nombre: "Inventario",
      desc: "Reporte del inventario completo",
      opcion: "inventario")
];
