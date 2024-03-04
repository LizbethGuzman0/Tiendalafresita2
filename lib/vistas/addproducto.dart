import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiendalafresita/controlador/categoria_controlador.dart';
import 'package:tiendalafresita/controlador/producto_controlador.dart';

class AddProductoPage extends StatelessWidget {
  AddProductoPage({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  final CategoriaControlador categoriaControlador = CategoriaControlador();

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
          'Agregar Producto',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFebacab),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: categoriaController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    String salida = ProductoControlador().agregarProducto(
                      idController.text,
                      nombreController.text,
                      double.parse(
                        precioController.text.isEmpty
                            ? '0'
                            : precioController.text,
                      ),
                      categoriaController.text,
                    );
                    if (salida == 'Producto agregado') {
                      idController.clear();
                      nombreController.clear();
                      precioController.clear();
                      categoriaController.clear();
                    }
                  },
                  child: const Text('AGREGAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
