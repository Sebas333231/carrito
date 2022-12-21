import 'package:flutter/material.dart';
import 'lista_productos.dart';

class Carrito extends StatefulWidget {
  final List<ListaProductos> _cart;

  const Carrito(this._cart,{super.key});

  @override
  _CarritoState createState() => _CarritoState(this._cart);
}

class _CarritoState extends State<Carrito> {
  _CarritoState(this._cart);

  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ListaProductos> _cart;
  Container pagoTotal(List<ListaProductos> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Iva: \$${ivaProducto(_cart)}",
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "SubTotal: \$${subtotalProducto(_cart)}",
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                  "Total:  \$${valorTotal(_cart)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.black)
              ),
            ],
          )
        ],
      ),
    );
  }
  String ivaProducto(cart) {
    double iva = 0.0;
    for (int i = 0; i < cart.length; i++) {
      iva = iva + cart[i].iva * cart[i].quantity;
    }
    return iva.toStringAsFixed(2);
  }
  String subtotalProducto(cart) {
    double subtotal = 0.0;
    for (int i = 0; i < cart.length; i++) {
      subtotal = subtotal + cart[i].precio * cart[i].quantity;
    }
    return subtotal.toStringAsFixed(2);
  }
  String valorTotal(cart) {
    double total = 0.0;

    for (int i = 0; i < cart.length; i++) {
      total = total + cart[i].precio * cart[i].quantity + cart[i].iva;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.restaurant_menu, size: 30, color: Colors.white),
            onPressed: null,
          )
        ],
        title: const Text('Detalle del Producto',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white)
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      //final String imagen = _cart[index].image;
                      var item = _cart[index];
                      return Column(
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    //Padding(
                                      //padding: const EdgeInsets.only(
                                        //top: 10,
                                      //),
                                    Expanded(
                                          child: Image(
                                            image: AssetImage(
                                                _cart[index].imageURL.toString(),
                                            ),
                                            width: 10,
                                            height: 100,
                                            alignment: Alignment.topLeft,
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20,
                                        left: 30,
                                      ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          _cart[index].nombre.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 6.0,
                                                      color: Colors.teal,
                                                      offset: Offset(0.0, 1.0),
                                                    )
                                                  ],
                                                  borderRadius: BorderRadius
                                                      .all(
                                                    Radius.circular(50.0),
                                                  )),
                                              margin: const EdgeInsets.only(
                                                  top: 20.0),
                                              padding: const EdgeInsets.all(2.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.remove),
                                                    onPressed: () {
                                                      setState(() {
                                                        _cart[index].quantity--;
                                                        valorTotal(_cart);
                                                      });
                                                    },
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(_cart[index]
                                                      .quantity.toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 22.0,
                                                          color: Colors.white)),
                                                  IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () {
                                                      setState(() {
                                                        _cart[index].quantity++;
                                                        valorTotal(_cart);
                                                      });
                                                    },
                                                    color: Colors.yellow,
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    ),
                                    const SizedBox(
                                      width: 38.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20,
                                      ),
                                    child: Column(
                                      children: [
                                        Text(item.precio.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0,
                                                color: Colors.black)
                                        ),
                                        Row(
                                          children: [
                                            Text('Iva '),
                                            Text(
                                              item.iva.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Colors.black
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.purple,
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  pagoTotal(_cart),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ))),
    );
  }
}
