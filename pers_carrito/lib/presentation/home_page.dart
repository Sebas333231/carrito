import 'package:flutter/material.dart';
import 'shopping_cart.dart' show Carrito;

import 'lista_productos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListaProductos> _productosModel = <ListaProductos>[];

  final List<ListaProductos> _listaCarro = <ListaProductos>[];
  @override
  void initState() {
    super.initState();
    _productos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Productos',
          style: TextStyle(fontSize: 35),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_listaCarro.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_listaCarro.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Carrito(_listaCarro)),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  '../image/pic1.jpg',
                ),
                fit: BoxFit.cover)),
        //height: MediaQuery.of(context).size.height / 1.5,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (0.9), crossAxisCount: 3),
          itemCount: _productosModel.length,
          itemBuilder: (context, index) {
            var item = _productosModel[index];
            return Card(
              color: Colors.grey,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        child: Image(
                          image: AssetImage(
                              _productosModel[index].imageURL.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 1,
                              ),
                              child: Text(
                                _productosModel[index].nombre.toString(),
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 1,
                              ),
                              child: Text(
                                _productosModel[index].precio.toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          color: Colors.blue.shade50,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (!_listaCarro.contains(item)) {
                                        _listaCarro.add(item);
                                      } else {
                                        _listaCarro.remove(item);
                                      }
                                    });
                                  },
                                  icon: (!_listaCarro.contains(item))
                                      ? const Icon(
                                          Icons.shopping_cart,
                                          size: 25,
                                        )
                                      : const Icon(
                                          Icons.shopping_cart_checkout,
                                          size: 30,
                                          color: Colors.green,
                                        )),
                              ElevatedButton(
                                onPressed: () {
                                  showDialogFunc(
                                      context,
                                      _productosModel[index].descripcion,
                                      _productosModel[index].titulo,
                                      _productosModel[index].imageURL);
                                },
                                child: const Text(
                                  'Informacion',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _productos() {
    var list = <ListaProductos>[
      ListaProductos(
          nombre: 'Pizza Familiar',
          precio: 40000,
          imageURL: '../image/pic8.jpeg',
          id: 1,
          iva: 2000,
          quantity: 1,
          titulo: 'Ingredientes',
          descripcion:
              """1 Taza Harina todo uso, Ajo En Polvo al gusto, Orégano Fresco al gusto, 1/2 Cucharadita Sal, 5 Cucharadas de Agua, 5 Cucharadas Aceite De  Oliva, 1/2 Taza MAGGI® La Rojita Puré de Tomate, Sal de Ajo al gusto,Sal de cebolla al gusto, 1 Unidad Tomate Riñón,1 Taza Queso Mozzarella, 2 Tazas Jamón, 1/2 Taza Aceitunas Verdes, Ají En Polvo al gusto""",
          isAdd: false),
      ListaProductos(
          nombre: 'Hamburguesa',
          precio: 16500,
          imageURL: '../image/pic3.jpeg',
          id: 2,
          iva: 825,
          quantity: 1,
          titulo: 'Ingredientes',
          descripcion:
              """Pan – Mezcla de suavidad y resistencia, Queso – Siempre fundido, Vegetales – Frescura al paladar, Salsas – Son una opción, Carne – La reina del sabor""",
          isAdd: false),
      ListaProductos(
          nombre: 'Salchipapas',
          precio: 11700,
          imageURL: '../image/pic9.jpeg',
          id: 3,
          quantity: 1,
          titulo: 'Ingredientes',
          descripcion:
              """4 papas grandes, 4 Salchichas Llanera, Aceite, Sal al gusto, queso, salsas al gusto, Huevos de codornis""",
          iva: 585,
          isAdd: false),
      ListaProductos(
          nombre: 'Perro Caliente',
          precio: 8900,
          imageURL: '../image/pic5.jpeg',
          id: 4,
          iva: 445,
          quantity: 1,
          titulo: 'Ingredientes',
          descripcion:
              """1 taza de chorizo cortado en cubos, 1/2 taza de cebollas blanca picada,1 chile serrano picado, 2 tazas de queso asadero rallado, 2 panes para hot dog, 2 salchichas para hot dog, 1/4 taza de frijoles negros, cocidos.""",
          isAdd: false),
      ListaProductos(
          nombre: 'Lasaña',
          precio: 17000,
          imageURL: '../image/pic4.jpeg',
          id: 5,
          iva: 850,
          quantity: 1,
          titulo: 'Ingredientes',
          descripcion:
              """"Los ingredientes que lleva esta lasaña, además de las láminas de pasta y la bechamel, son la mozzarella, scamorza, huevos, albóndigas, ricota, ragú napolitano, jamón y embutido mezclado con zanahoria, apio y, por supuesto, la salsa napolitana.""",
          isAdd: false),
    ];
    setState(() {
      _productosModel = list;
    });
  }

  showDialogFunc(context, descripcion, titulo, imageURL) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  //opacity: 10,
                  image: AssetImage(
                    '../image/pic2.jpeg',
                  ),
                  fit: BoxFit.cover,
                  //borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(35),
              height: 550,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        titulo,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        imageURL,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text(
                          descripcion,
                          maxLines: 30,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
