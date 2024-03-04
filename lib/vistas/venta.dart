import 'package:flutter/material.dart';
import 'package:tiendalafresita/controlador/venta_controller.dart';
import 'package:tiendalafresita/modelo/Venta.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({super.key});

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  final VentaController ventaController = VentaController();
  final TextEditingController codigoController = TextEditingController();
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
          'Venta',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFebacab),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ventaController.productos.isEmpty
                  ? const Center(
                      child: Text('No hay productos'),
                    )
                  : ListView.builder(
                      itemCount: ventaController.productos.length,
                      itemBuilder: (context, index) {
                        var fila = ventaController.productos[index];
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
                            title: Text(fila.producto.nombre),
                            subtitle: Text('\$${fila.subtotal}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.pink[100]!,
                                    ),
                                  ),
                                  onPressed: () {
                                    ventaController.agregarProducto(
                                      fila.producto.id,
                                      -1,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  child: Text(fila.cantidad.toString()),
                                ),
                                IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.pink[100]!,
                                    ),
                                  ),
                                  onPressed: () {
                                    ventaController.agregarProducto(
                                      fila.producto.id,
                                      1,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            onTap: () {
                              ventaController.eliminarProducto(fila.producto);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Código',
                      border: OutlineInputBorder(),
                    ),
                    controller: codigoController,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      String salida = ventaController.agregarProducto(
                        codigoController.text,
                        1,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(salida),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      setState(() {});
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Venta venta = ventaController.crearVenta();
                ventaController.guardarVenta(venta);

                ventaController.productos.clear();

                setState(() {});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Venta realizada'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              label: const Text(
                'Pagar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFebacab),
                ),
              ),
              icon: const Icon(
                Icons.payment_rounded,
                color: Color.fromARGB(255, 146, 71, 70),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
