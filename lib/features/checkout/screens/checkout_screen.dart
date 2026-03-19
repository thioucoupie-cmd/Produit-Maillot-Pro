import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produit_maillot_pro/features/cart/providers/cart_provider.dart';
import 'package:produit_maillot_pro/shared/theme/app_theme.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPaymentMethod = 'Stripe';
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = ref.watch(cartProvider.notifier).totalAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PAIEMENT'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ADRESSE DE LIVRAISON',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Entrez votre adresse complète',
                prefixIcon: const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Map Placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, color: AppTheme.accentColor),
                    SizedBox(height: 8),
                    Text('Sélectionner sur la carte', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'MODE DE PAIEMENT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildPaymentOption('Stripe', Icons.credit_card),
                const SizedBox(width: 16),
                _buildPaymentOption('Mobile Money', Icons.phone_android),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'RÉCAPITULATIF',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Sous-total', totalAmount),
            _buildSummaryRow('Livraison', 2000),
            const Divider(height: 32, color: Colors.white24),
            _buildSummaryRow('TOTAL', totalAmount + 2000, isBold: true),
            const SizedBox(height: 48),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.primaryBackground,
          border: Border(top: BorderSide(color: Colors.white12)),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Process payment
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Paiement en cours de traitement...'),
                backgroundColor: AppTheme.accentColor,
              ),
            );
          },
          child: const Text('CONFIRMER ET PAYER'),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String name, IconData icon) {
    final isSelected = selectedPaymentMethod == name;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedPaymentMethod = name),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.accentColor.withOpacity(0.1) : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppTheme.accentColor : Colors.white24,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? AppTheme.accentColor : Colors.white),
              const SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  color: isSelected ? AppTheme.accentColor : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isBold ? Colors.white : Colors.white70)),
          Text(
            '${amount.toStringAsFixed(0)} FCFA',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
              color: isBold ? AppTheme.accentColor : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
