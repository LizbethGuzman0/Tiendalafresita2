import 'package:flutter/material.dart';
import 'package:tiendalafresita/controlador/producto_controlador.dart';
import 'package:tiendalafresita/vistas/addproducto.dart';
import 'package:tiendalafresita/vistas/infoproducto.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({super.key});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  ProductoControlador controlador = ProductoControlador();
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
          'Productos',
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
                      subtitle: Text(controlador.productos[index].categoria),
                      trailing: Text(
                        '\$${controlador.productos[index].precio}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoProductoPage(
                              producto: controlador.productos[index],
                            ),
                          ),
                        ).then(
                          (value) {
                            setState(() {});
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductoPage(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        label: const Text('Agregar Producto'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
