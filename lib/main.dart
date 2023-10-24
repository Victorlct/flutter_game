import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cards game flutter nice'),
        ),
        body: CardList(),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  int vida = 0;
  int energia = 0;
  int defesa = 0;

  int maxVida = 1000;
  int maxEnergia = 1000;
  int maxDefesa = 1000;

  void increaseAttribute(int attribute) {
    if (attribute == 0) {
      if (vida + 50 >= maxVida) {
        setState(() {
          vida = 0;
          maxVida = (maxVida! * 1.10).toInt();
        });
      } else {
        setState(() {
          vida += 50;
        });
      }
    } else if (attribute == 1) {
      if (energia + 50 >= maxEnergia) {
        setState(() {
          energia = 0;
          maxEnergia = (maxEnergia! * 1.10).toInt();
        });
      } else {
        setState(() {
          energia += 50;
        });
      }
    } else if (attribute == 2) {
      if (defesa + 50 >= maxDefesa) {
        setState(() {
          defesa = 0;
          maxDefesa = (maxDefesa! * 1.10).toInt();
        });
      } else {
        setState(() {
          defesa += 50;
        });
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CardDetailsScreen(
                      label: "Vida",
                      value: vida,
                      max: maxVida,
                      attribute: 0,
                    ),
                  ));
                },
                child: Hero(
                  tag: 'vida',
                  child: CardItem(
                    label: "Vida",
                    value: vida,
                    totalValue: maxVida,
                    color: Colors.red,
                    borderRadius: 10.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CardDetailsScreen(
                      label: "Energia",
                      value: energia,
                      max: maxEnergia,
                      attribute: 1,
                    ),
                  ));
                },
                child: Hero(
                  tag: 'energia',
                  child: CardItem(
                    label: "Energia",
                    value: energia,
                    totalValue: maxEnergia,
                    color: Colors.yellow,
                    borderRadius: 10.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CardDetailsScreen(
                      label: "Defesa",
                      value: defesa,
                      max: maxDefesa,
                      attribute: 2,
                    ),
                  ));
                },
                child: Hero(
                  tag: 'defesa',
                  child: CardItem(
                    label: "Defesa",
                    value: defesa,
                    totalValue: maxDefesa,
                    color: Colors.blue,
                    borderRadius: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  increaseAttribute(0);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  increaseAttribute(1);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                ),
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  increaseAttribute(2);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final String label;
  final int value;
  final int totalValue;
  final Color color;
  final double borderRadius;

  CardItem({
    required this.label,
    required this.value,
    required this.totalValue,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(
                  value: value / totalValue,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
                Text(
                  '$value',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardDetailsScreen extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final int attribute;

  CardDetailsScreen({
    required this.label,
    required this.value,
    required this.max,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nível do Card: ${max ~/ 100 - 10}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Limite de ${label}: $max',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
