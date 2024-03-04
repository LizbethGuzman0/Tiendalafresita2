import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiendalafresita/controlador/categoria_controlador.dart';
import 'package:tiendalafresita/controlador/producto_controlador.dart';
import 'package:tiendalafresita/modelo/Producto.dart';

class InfoProductoPage extends StatefulWidget {
  final Producto producto;
  const InfoProductoPage({super.key, required this.producto});

  @override
  State<InfoProductoPage> createState() => _EditProductoPageState();
}

class _EditProductoPageState extends State<InfoProductoPage> {
  final ProductoControlador controlador = ProductoControlador();
  final CategoriaControlador categoriaControlador = CategoriaControlador();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Producto p = widget.producto;
    idController.text = p.id.toString();
    nombreController.text = p.nombre;
    precioController.text = p.precio.toString();
    categoriaController.text = p.categoria;
  }

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
          'Editar Producto',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
                // enabled: false,
                readOnly: true,
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
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          controlador.eliminarProducto(widget.producto.id);
                          Navigator.pop(context);
                        },
                        child: const Text('Eliminar'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          controlador.editarProducto(
                            widget.producto.id,
                            nombreController.text,
                            double.parse(
                              precioController.text.isEmpty
                                  ? '0'
                                  : precioController.text,
                            ),
                            categoriaController.text,
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Editar'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
