// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price Data'),
      ),
      body: Consumer<PriceProvider>(   
        builder: (context, priceProvider, child) {
          if (priceProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          var prices;
          return ListView.builder(
            itemCount: priceProvider.prices.length,
            itemBuilder: (context, index) {
              var prices;
              final price = priceProvider.prices[index];
              return ListTile(
                title: Text(price.name),
                subtitle: Text('\$${price.price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PriceProvider>().fetchPrices();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
  
}

mixin PriceProvider {
  void fetchPrices() {}
}


