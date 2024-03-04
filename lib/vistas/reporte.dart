import 'package:flutter/material.dart';
import 'package:tiendalafresita/controlador/venta_controller.dart';

class ReportePage extends StatefulWidget {
  const ReportePage({super.key});

  @override
  State<ReportePage> createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  VentaController ventaController = VentaController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFebacab),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Reporte',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFebacab),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: ventaController.ventas.isEmpty
          ? const Center(
              child: Text('No hay ventas'),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: ventaController.ventas.length,
                itemBuilder: (context, index) {
                  var venta = ventaController.ventas[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pink[100]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Text(
                        venta.id,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Text(
                        'Total: \$${venta.total}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Text(venta.fecha.split('.')[0]),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('N° ${venta.id}'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (var fila in venta.productos)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.pink[100]!,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${fila.cantidad} x ${fila.producto.nombre} = \$${fila.subtotal}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  Text(
                                    'Total: \$${venta.total}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Fecha: ${venta.fecha.split('.')[0]}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink[100],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cerrar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
