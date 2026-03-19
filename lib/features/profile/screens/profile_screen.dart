import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produit_maillot_pro/core/services/auth_service.dart';
import 'package:produit_maillot_pro/features/profile/screens/login_screen.dart';
import 'package:produit_maillot_pro/shared/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFIL'),
        actions: [
          if (user != null)
            IconButton(
              onPressed: () async {
                await authService.signOut();
                if (context.mounted) Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: user == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_outline, size: 80, color: Colors.white24),
                  const SizedBox(height: 24),
                  const Text('Connectez-vous pour voir votre profil'),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text('SE CONNECTER'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.accentColor,
                    child: Icon(Icons.person, size: 60, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.email ?? 'Utilisateur',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 48),
                  _buildProfileItem(Icons.history, 'Historique des commandes'),
                  _buildProfileItem(Icons.location_on_outlined, 'Adresses de livraison'),
                  _buildProfileItem(Icons.payment, 'Modes de paiement'),
                  _buildProfileItem(Icons.settings_outlined, 'Paramètres'),
                  const SizedBox(height: 32),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 32),
                  const Text(
                    'PRODUIT-MAILLOT PRO v1.0.0',
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppTheme.accentColor),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right, color: Colors.white24),
          onTap: () {},
        ),
        const Divider(color: Colors.white10),
      ],
    );
  }
}
