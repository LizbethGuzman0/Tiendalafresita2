import 'package:flutter/material.dart';
import 'package:tiendalafresita/controlador/categoria_controlador.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  CategoriaControlador categoriaControlador = CategoriaControlador();
  TextEditingController nombreController = TextEditingController();
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
          'Categorías',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFFebacab),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: categoriaControlador.categorias.isEmpty
          ? const Center(
              child: Text('No hay categorías'),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: categoriaControlador.categorias.length,
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
                      title: Text(categoriaControlador.categorias[index]),
                      onTap: () {
                        nombreController.text =
                            categoriaControlador.categorias[index];
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Editar Categoría'),
                              content: TextField(
                                controller: nombreController,
                                decoration: const InputDecoration(
                                  labelText: 'Nombre',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    categoriaControlador.editarCategoria(
                                        index, nombreController.text);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Editar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    categoriaControlador
                                        .eliminarCategoria(index);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Eliminar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Agregar Categoría'),
                content: TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      categoriaControlador
                          .agregarCategoria(nombreController.text);
                      setState(() {});
                      nombreController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Agregar'),
                  ),
                ],
              );
            },
          );
        },
        label: const Text('Agregar Categoría'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
