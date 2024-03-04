import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiendalafresita/controlador/producto_controlador.dart';

class ExistenciasPage extends StatefulWidget {
  const ExistenciasPage({super.key});

  @override
  State<ExistenciasPage> createState() => _ExistenciasPageState();
}

class _ExistenciasPageState extends State<ExistenciasPage> {
  ProductoControlador controlador = ProductoControlador();
  TextEditingController cantidadController = TextEditingController();
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
          'Existencias',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFebacab),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: controlador.productos.isEmpty
          ? const Center(
              child: Text('No hay productos'),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: controlador.productos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFebacab),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text(controlador.productos[index].nombre),
                      subtitle: Text(
                          'Existencias: ${controlador.productos[index].cantidad}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Agregar Stock'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: cantidadController,
                                    decoration: const InputDecoration(
                                      labelText: 'Cantidad',
                                      border: OutlineInputBorder(),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+'),
                                      ),
                                    ],
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controlador.agregarCantidad(
                                        controlador.productos[index].id,
                                        int.parse(cantidadController.text),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Agregar'),
                                  )
                                ],
                              ),
                            );
                          },
                        ).then((value) {
                          setState(() {});
                          cantidadController.clear();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
