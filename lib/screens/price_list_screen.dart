import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/price_provider.dart';

class PriceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prices List'),
      ),
      body: Consumer<PriceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.prices.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: provider.prices.length,
              itemBuilder: (context, index) {
                final price = provider.prices[index];
                return ListTile(
                  title: Text(price.name),
                  subtitle: Text(price.price.toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PriceProvider>().fetchAndSavePrices(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
