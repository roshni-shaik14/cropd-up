import 'ai_price_service.dart';
import 'recommendation_service.dart';
import 'package:flutter/material.dart';

import 'app_language.dart';
import 'shop_finder_screen.dart';

void main() {
  runApp(const CropDUpApp());
}

// ============================================================
// DATA MODELS
// ============================================================

class CropListing {
  final String id;
  final String name;
  final String quantity;
  final String price;
  final String location;
  final String farmer;
  final String category;

  bool available;

  CropListing({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.location,
    required this.farmer,
    required this.category,
    this.available = true,
  });
}

class MarketPrice {
  final String crop;
  final String unit;
  final double minPrice;
  final double maxPrice;
  final double averagePrice;
  final String trend;

  const MarketPrice({
    required this.crop,
    required this.unit,
    required this.minPrice,
    required this.maxPrice,
    required this.averagePrice,
    required this.trend,
  });
}

class SeedShop {
  final String name;
  final String location;
  final String category;
  final double rating;

  const SeedShop({
    required this.name,
    required this.location,
    required this.category,
    required this.rating,
  });
}

// ============================================================
// DEMO DATA
// ============================================================

final List<CropListing> cropListings = [
  CropListing(
    id: '1',
    name: 'Tomato',
    quantity: '500',
    price: '27',
    location: 'Bengaluru',
    farmer: 'Local Farmer',
    category: 'Vegetables',
  ),
  CropListing(
    id: '2',
    name: 'Onion',
    quantity: '300',
    price: '32',
    location: 'Mysuru',
    farmer: 'Ravi Kumar',
    category: 'Vegetables',
  ),
  CropListing(
    id: '3',
    name: 'Potato',
    quantity: '450',
    price: '29',
    location: 'Tumakuru',
    farmer: 'Lakshmi Farms',
    category: 'Vegetables',
  ),
];

const List<MarketPrice> marketPrices = [
  MarketPrice(
    crop: 'Tomato',
    unit: 'kg',
    minPrice: 25,
    maxPrice: 30,
    averagePrice: 27,
    trend: 'Stable',
  ),
  MarketPrice(
    crop: 'Onion',
    unit: 'kg',
    minPrice: 28,
    maxPrice: 36,
    averagePrice: 32,
    trend: 'Rising',
  ),
  MarketPrice(
    crop: 'Potato',
    unit: 'kg',
    minPrice: 26,
    maxPrice: 34,
    averagePrice: 29,
    trend: 'Stable',
  ),
  MarketPrice(
    crop: 'Rice',
    unit: 'kg',
    minPrice: 40,
    maxPrice: 50,
    averagePrice: 45,
    trend: 'Stable',
  ),
  MarketPrice(
    crop: 'Wheat',
    unit: 'kg',
    minPrice: 28,
    maxPrice: 38,
    averagePrice: 33,
    trend: 'Falling',
  ),
];

const List<SeedShop> seedShops = [
  SeedShop(
    name: 'Green Farm Seeds',
    location: 'Bengaluru',
    category: 'Vegetable Seeds',
    rating: 4.6,
  ),
  SeedShop(
    name: 'AgriGrow Seeds',
    location: 'Mysuru',
    category: 'Hybrid Seeds',
    rating: 4.4,
  ),
  SeedShop(
    name: 'Farmers Choice',
    location: 'Tumakuru',
    category: 'Organic Seeds',
    rating: 4.7,
  ),
];

// ============================================================
// APP
// ============================================================

class CropDUpApp extends StatelessWidget {
  const CropDUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appLanguageController,
      builder: (context, _) {
        return MaterialApp(
          title: "Crop'D UP",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green,
            scaffoldBackgroundColor: const Color(0xFFF7FAF7),
            appBarTheme: const AppBarTheme(
              centerTitle: false,
              elevation: 0,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
            ),
          ),

          // Key changes whenever language changes.
          // This guarantees the complete app tree rebuilds.
          home: WelcomeScreen(
            key: ValueKey(
              appLanguageController.language,
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// WELCOME
// ============================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _openFarmer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FarmerShell(),
      ),
    );
  }

  void _openBuyer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BuyerShell(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = appLanguageController.language;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 35),

                  // LOGO
                  Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        '🌾',
                        style: TextStyle(
                          fontSize: 54,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // APP NAME
                  const Text(
                    "CROP'D UP",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // TAGLINE
                  Text(
                    '${AppText.betterPrices(language)}\n'
                    '${AppText.morePower(language)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 42),

                  // FARMER
                  _LargeRoleButton(
                    icon: '👨‍🌾',
                    title: AppText.farmer(language),
                    subtitle: AppText.farmerSubtitle(language),
                    filled: true,
                    onTap: () => _openFarmer(context),
                  ),

                  const SizedBox(height: 16),

                  // BUYER
                  _LargeRoleButton(
                    icon: '🛒',
                    title: AppText.buyer(language),
                    subtitle: AppText.buyerSubtitle(language),
                    filled: false,
                    onTap: () => _openBuyer(context),
                  ),

                  const SizedBox(height: 28),

                  // LANGUAGE
                  TextButton.icon(
                    onPressed: () {
                      _showLanguageDialog(context);
                    },
                    icon: const Icon(
                      Icons.language,
                    ),
                    label: Text(
                      appLanguageController.languageName,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    AppText.connecting(language),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: Text(
            AppText.chooseLanguage(
              appLanguageController.language,
            ),
          ),

          children: [
            SimpleDialogOption(
              onPressed: () {
                appLanguageController.setLanguage(
                  AppLanguage.english,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('English'),
            ),

            SimpleDialogOption(
              onPressed: () {
                appLanguageController.setLanguage(
                  AppLanguage.kannada,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('ಕನ್ನಡ'),
            ),

            SimpleDialogOption(
              onPressed: () {
                appLanguageController.setLanguage(
                  AppLanguage.hindi,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('हिन्दी'),
            ),

            SimpleDialogOption(
              onPressed: () {
                appLanguageController.setLanguage(
                  AppLanguage.telugu,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('తెలుగు'),
            ),

            SimpleDialogOption(
              onPressed: () {
                appLanguageController.setLanguage(
                  AppLanguage.tamil,
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('தமிழ்'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// ROLE BUTTON
// ============================================================

class _LargeRoleButton extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool filled;
  final VoidCallback onTap;

  const _LargeRoleButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: filled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: _content(),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green.shade800,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 17,
                ),
                side: BorderSide(
                  color: Colors.green.shade700,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: _content(),
            ),
    );
  }

  Widget _content() {
    return Row(
      children: [
        Text(
          icon,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
      ],
    );
  }
}

// ============================================================
// FARMER SHELL
// ============================================================

class FarmerShell extends StatefulWidget {
  const FarmerShell({super.key});

  @override
  State<FarmerShell> createState() => _FarmerShellState();
}

class _FarmerShellState extends State<FarmerShell> {
  int _index = 0;

  void _refresh() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _addCrop() async {
    final added = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddCropScreen(),
      ),
    );

    if (!mounted) return;

    if (added == true) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      AppText.get('farmerDashboard'),
      AppText.get('marketPrices'),
      AppText.get('myCrops'),
      AppText.get('profile'),
    ];

    final pages = [
      FarmerHome(onRefresh: _refresh),
      const MarketPricesScreen(),
      FarmerCropsScreen(onRefresh: _refresh),
      const ProfileScreen(role: 'Farmer'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_index],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: AppText.get('notifications'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),
      body: pages[_index],
      floatingActionButton: _index == 0 || _index == 2
          ? FloatingActionButton.extended(
              onPressed: _addCrop,
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: Text(
                AppText.get('addCrop'),
              ),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.dashboard_outlined,
            ),
            selectedIcon: const Icon(
              Icons.dashboard,
            ),
            label: AppText.get('home'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.trending_up_outlined,
            ),
            selectedIcon: const Icon(
              Icons.trending_up,
            ),
            label: AppText.get('market'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.eco_outlined,
            ),
            selectedIcon: const Icon(
              Icons.eco,
            ),
            label: AppText.get('myCrops'),
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.person_outline,
            ),
            selectedIcon: const Icon(
              Icons.person,
            ),
            label: AppText.get('profile'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FARMER HOME
// ============================================================

class FarmerHome extends StatelessWidget {
  final VoidCallback onRefresh;

  const FarmerHome({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
      },
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _GreetingCard(
            name: 'Farmer',
            subtitle: AppText.get('manageCropsPrices'),
            icon: '👨‍🌾',
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: AppText.get('listings'),
                  value: '${cropListings.length}',
                  icon: Icons.inventory_2_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  title: AppText.get('available'),
                  value:
                      '${cropListings.where((c) => c.available).length}',
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            AppText.get('myCropListings'),
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (cropListings.isEmpty)
            _EmptyState(
              icon: Icons.eco_outlined,
              title: AppText.get('noCropsYet'),
              message: AppText.get('addFirstCrop'),
            )
          else
            ...cropListings.map(
              (crop) => CropCard(
                crop: crop,
                showFarmer: false,
              ),
            ),

          const SizedBox(height: 20),

          Text(
            AppText.get('smartTools'),
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _ToolTile(
            icon: Icons.auto_awesome,
            title: AppText.get(
              'aiPriceRecommendation',
            ),
            subtitle: AppText.get(
              'suggestedSellingPrice',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AIPriceScreen(),
                ),
              );
            },
          ),

          _ToolTile(
            icon: Icons.storefront_outlined,
            title: AppText.get('seedShops'),
            subtitle: AppText.get(
              'nearbySeedSuppliers',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SeedShopsScreen(),
                ),
              );
            },
          ),

          _ToolTile(
            icon: Icons.notifications_none,
            title: AppText.get('notifications'),
            subtitle: AppText.get(
              'updatesBuyerRequests',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FARMER CROPS
// ============================================================

class FarmerCropsScreen extends StatelessWidget {
  final VoidCallback onRefresh;

  const FarmerCropsScreen({
    super.key,
    required this.onRefresh,
  });

  Future<void> _deleteCrop(
    BuildContext context,
    CropListing crop,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Crop?'),
          content: Text(
            'Are you sure you want to delete ${crop.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    cropListings.removeWhere(
      (item) => item.id == crop.id,
    );

    onRefresh();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${crop.name} deleted successfully',
        ),
      ),
    );
  }

  void _toggleAvailability(
    BuildContext context,
    CropListing crop,
  ) {
    crop.available = !crop.available;

    onRefresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          crop.available
              ? '${crop.name} marked as available'
              : '${crop.name} marked as sold',
        ),
      ),
    );
  }

  Future<void> _editCrop(
    BuildContext context,
    CropListing crop,
  ) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            EditCropScreen(crop: crop),
      ),
    );

    if (updated == true) {
      onRefresh();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Crop updated successfully',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cropListings.isEmpty) {
      return const _EmptyState(
        icon: Icons.eco_outlined,
        title: 'No crops yet',
        message:
            'Add your first crop listing to get started.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(
          '${cropListings.length} crop listings',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        ...cropListings.map(
          (crop) => Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CropCard(
                      crop: crop,
                      showFarmer: false,
                    ),
                  ),
                  PopupMenuButton<String>(
                    tooltip: 'Crop actions',
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _editCrop(
                            context,
                            crop,
                          );
                          break;

                        case 'toggle':
                          _toggleAvailability(
                            context,
                            crop,
                          );
                          break;

                        case 'delete':
                          _deleteCrop(
                            context,
                            crop,
                          );
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(
                            Icons.edit_outlined,
                          ),
                          title: Text(
                            'Edit Crop',
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'toggle',
                        child: ListTile(
                          leading: Icon(
                            crop.available
                                ? Icons
                                    .check_circle_outline
                                : Icons.refresh,
                          ),
                          title: Text(
                            crop.available
                                ? 'Mark as Sold'
                                : 'Mark as Available',
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(
                            Icons.delete_outline,
                          ),
                          title: Text(
                            'Delete Crop',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// ADD CROP
// ============================================================

class AddCropScreen extends StatefulWidget {
  const AddCropScreen({super.key});

  @override
  State<AddCropScreen> createState() =>
      _AddCropScreenState();
}

class _AddCropScreenState
    extends State<AddCropScreen> {
  final _formKey = GlobalKey<FormState>();

  final _cropController =
      TextEditingController();

  final _quantityController =
      TextEditingController();

  final _priceController =
      TextEditingController();

  final _locationController =
      TextEditingController();

  String _category = 'Vegetables';

  @override
  void dispose() {
    _cropController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    cropListings.insert(
      0,
      CropListing(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: _cropController.text.trim(),
        quantity:
            _quantityController.text.trim(),
        price: _priceController.text.trim(),
        location:
            _locationController.text.trim(),
        farmer: 'Local Farmer',
        category: _category,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Crop listing added successfully 🌱',
        ),
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;
        Navigator.pop(context, true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add My Crop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Create a Crop Listing 🌱',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Provide basic details about the crop you want to sell.',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 25),

            TextFormField(
              controller: _cropController,
              decoration: const InputDecoration(
                labelText: 'Crop Name',
                hintText: 'Example: Tomato',
                prefixIcon: Icon(Icons.eco),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the crop name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration:
                  const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(
                  Icons.category_outlined,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Vegetables',
                  child: Text('Vegetables'),
                ),
                DropdownMenuItem(
                  value: 'Fruits',
                  child: Text('Fruits'),
                ),
                DropdownMenuItem(
                  value: 'Grains',
                  child: Text('Grains'),
                ),
                DropdownMenuItem(
                  value: 'Pulses',
                  child: Text('Pulses'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _category = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
                  _quantityController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'Quantity',
                hintText: 'Example: 500',
                prefixIcon: Icon(
                  Icons.inventory_2_outlined,
                ),
                suffixText: 'kg',
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the quantity';
                }

                final number =
                    double.tryParse(value);

                if (number == null ||
                    number <= 0) {
                  return 'Enter a valid quantity';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'Expected Price',
                hintText: 'Example: 27',
                prefixIcon: Icon(
                  Icons.currency_rupee,
                ),
                suffixText: '/kg',
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter your expected price';
                }

                final number =
                    double.tryParse(value);

                if (number == null ||
                    number <= 0) {
                  return 'Enter a valid price';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
                  _locationController,
              decoration:
                  const InputDecoration(
                labelText: 'Location',
                hintText: 'Example: Bengaluru',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the location';
                }
                return null;
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 58,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Add Listing',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green.shade700,
                  foregroundColor:
                      Colors.white,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EDIT CROP
// ============================================================

class EditCropScreen extends StatefulWidget {
  final CropListing crop;

  const EditCropScreen({
    super.key,
    required this.crop,
  });

  @override
  State<EditCropScreen> createState() =>
      _EditCropScreenState();
}

class _EditCropScreenState
    extends State<EditCropScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController
      _cropController;

  late final TextEditingController
      _quantityController;

  late final TextEditingController
      _priceController;

  late final TextEditingController
      _locationController;

  late String _category;

  @override
  void initState() {
    super.initState();

    _cropController =
        TextEditingController(
      text: widget.crop.name,
    );

    _quantityController =
        TextEditingController(
      text: widget.crop.quantity,
    );

    _priceController =
        TextEditingController(
      text: widget.crop.price,
    );

    _locationController =
        TextEditingController(
      text: widget.crop.location,
    );

    _category = widget.crop.category;
  }

  @override
  void dispose() {
    _cropController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final index =
        cropListings.indexWhere(
      (item) => item.id == widget.crop.id,
    );

    if (index != -1) {
      cropListings[index] = CropListing(
        id: widget.crop.id,
        name: _cropController.text.trim(),
        quantity:
            _quantityController.text.trim(),
        price: _priceController.text.trim(),
        location:
            _locationController.text.trim(),
        farmer: widget.crop.farmer,
        category: _category,
        available: widget.crop.available,
      );
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Crop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'Update Crop Details 🌱',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            TextFormField(
              controller: _cropController,
              decoration: const InputDecoration(
                labelText: 'Crop Name',
                prefixIcon: Icon(Icons.eco),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the crop name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration:
                  const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(
                  Icons.category_outlined,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Vegetables',
                  child: Text('Vegetables'),
                ),
                DropdownMenuItem(
                  value: 'Fruits',
                  child: Text('Fruits'),
                ),
                DropdownMenuItem(
                  value: 'Grains',
                  child: Text('Grains'),
                ),
                DropdownMenuItem(
                  value: 'Pulses',
                  child: Text('Pulses'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _category = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
                  _quantityController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: 'Quantity',
                suffixText: 'kg',
                prefixIcon: Icon(
                  Icons.inventory_2_outlined,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the quantity';
                }

                final number =
                    double.tryParse(value);

                if (number == null ||
                    number <= 0) {
                  return 'Enter a valid quantity';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration:
                  const InputDecoration(
                labelText: 'Expected Price',
                suffixText: '/kg',
                prefixIcon: Icon(
                  Icons.currency_rupee,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the price';
                }

                final number =
                    double.tryParse(value);

                if (number == null ||
                    number <= 0) {
                  return 'Enter a valid price';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller:
                  _locationController,
              decoration:
                  const InputDecoration(
                labelText: 'Location',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Enter the location';
                }

                return null;
              },
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(
                  Icons.save_outlined,
                ),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green.shade700,
                  foregroundColor:
                      Colors.white,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BUYER SHELL
// ============================================================

class BuyerShell extends StatefulWidget {
  const BuyerShell({super.key});

  @override
  State<BuyerShell> createState() =>
      _BuyerShellState();
}

class _BuyerShellState
    extends State<BuyerShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const BuyerHome(),
      const MarketPricesScreen(),
      const BuyerRequestsScreen(),
      const ProfileScreen(role: 'Buyer'),
    ];

    final titles = [
      'Buyer Dashboard',
      'Market Prices',
      'My Requests',
      'Profile',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_index],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const NotificationsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.storefront_outlined,
            ),
            selectedIcon: Icon(
              Icons.storefront,
            ),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.trending_up_outlined,
            ),
            selectedIcon: Icon(
              Icons.trending_up,
            ),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_bag_outlined,
            ),
            selectedIcon: Icon(
              Icons.shopping_bag,
            ),
            label: 'Requests',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
            ),
            selectedIcon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BUYER HOME
// ============================================================

class BuyerHome extends StatefulWidget {
  const BuyerHome({super.key});

  @override
  State<BuyerHome> createState() =>
      _BuyerHomeState();
}

class _BuyerHomeState
    extends State<BuyerHome> {
  String _query = '';
  String _category = 'All';

  List<CropListing> get _filtered {
    return cropListings.where((crop) {
      final matchesSearch =
          crop.name.toLowerCase().contains(
                _query.toLowerCase(),
              ) ||
          crop.location.toLowerCase().contains(
                _query.toLowerCase(),
              );

      final matchesCategory =
          _category == 'All' ||
          crop.category == _category;

      return matchesSearch &&
          matchesCategory &&
          crop.available;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const _GreetingCard(
          name: 'Buyer',
          subtitle:
              'Find fresh crops directly from farmers.',
          icon: '🛒',
        ),

        const SizedBox(height: 18),

        TextField(
          decoration:
              const InputDecoration(
            hintText:
                'Search crops or locations...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              _query = value;
            });
          },
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection:
                Axis.horizontal,
            children: [
              _CategoryChip(
                label: 'All',
                selected:
                    _category == 'All',
                onTap: () {
                  setState(
                    () => _category = 'All',
                  );
                },
              ),
              _CategoryChip(
                label: 'Vegetables',
                selected:
                    _category ==
                        'Vegetables',
                onTap: () {
                  setState(
                    () => _category =
                        'Vegetables',
                  );
                },
              ),
              _CategoryChip(
                label: 'Fruits',
                selected:
                    _category == 'Fruits',
                onTap: () {
                  setState(
                    () => _category =
                        'Fruits',
                  );
                },
              ),
              _CategoryChip(
                label: 'Grains',
                selected:
                    _category == 'Grains',
                onTap: () {
                  setState(
                    () => _category =
                        'Grains',
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        Text(
          '${_filtered.length} crops available',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(height: 10),

        if (_filtered.isEmpty)
          const _EmptyState(
            icon: Icons.search_off,
            title: 'No crops found',
            message:
                'Try another crop or location.',
          )
        else
          ..._filtered.map(
            (crop) => CropCard(
              crop: crop,
              showFarmer: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CropDetailsScreen(
                      crop: crop,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

// ============================================================
// CROP DETAILS
// ============================================================

class CropDetailsScreen
    extends StatelessWidget {
  final CropListing crop;

  const CropDetailsScreen({
    super.key,
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crop Details',
        ),
        backgroundColor:
            Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(22),
              child: Column(
                children: [
                  Text(
                    _cropEmoji(crop.name),
                    style:
                        const TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    crop.name,
                    style:
                        const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    crop.category,
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          _DetailRow(
            icon:
                Icons.inventory_2_outlined,
            label: 'Quantity',
            value:
                '${crop.quantity} kg',
          ),

          _DetailRow(
            icon:
                Icons.currency_rupee,
            label: 'Price',
            value:
                '₹${crop.price}/kg',
          ),

          _DetailRow(
            icon:
                Icons.location_on_outlined,
            label: 'Location',
            value: crop.location,
          ),

          _DetailRow(
            icon: Icons.person_outline,
            label: 'Farmer',
            value: crop.farmer,
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: crop.available
                  ? () {
                      _showRequestDialog(
                        context,
                      );
                    }
                  : null,
              icon: const Icon(
                Icons.handshake_outlined,
              ),
              label: Text(
                crop.available
                    ? 'Request This Crop'
                    : 'Crop Sold',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green.shade700,
                foregroundColor:
                    Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRequestDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Request Sent',
        ),
        content: Text(
          'Your request for ${crop.name} has been recorded in this demo.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MARKET PRICES
// ============================================================

class MarketPricesScreen
    extends StatelessWidget {
  const MarketPricesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Market Prices 📊',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'Indicative market prices for demonstration.',
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(height: 20),

        ...marketPrices.map(
          (item) => Card(
            margin:
                const EdgeInsets.only(
              bottom: 12,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Colors.green.shade100,
                    child: Text(
                      _cropEmoji(
                        item.crop,
                      ),
                      style:
                          const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          item.crop,
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '₹${item.minPrice.toStringAsFixed(0)} - '
                          '₹${item.maxPrice.toStringAsFixed(0)}/'
                          '${item.unit}',
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .end,
                    children: [
                      Text(
                        '₹${item.averagePrice.toStringAsFixed(0)}',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        item.trend,
                        style:
                            TextStyle(
                          color:
                              item.trend ==
                                      'Rising'
                                  ? Colors.green
                                      .shade700
                                  : item.trend ==
                                          'Falling'
                                      ? Colors.orange
                                          .shade700
                                      : Colors.grey
                                          .shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Card(
          color: Colors.green.shade50,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These values are demo data for the MVP. '
                    'Live market-price integration will be connected '
                    'through the backend later.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// ============================================================
// AI PRICE SCREEN
// ============================================================

class AIPriceScreen extends StatefulWidget {
  const AIPriceScreen({
    super.key,
  });

  @override
  State<AIPriceScreen> createState() =>
      _AIPriceScreenState();
}

class _AIPriceScreenState extends State<AIPriceScreen> {
  String _crop = 'Tomato';

  final TextEditingController _quantityController =
      TextEditingController(
    text: '500',
  );

  final TextEditingController _locationController =
      TextEditingController(
    text: 'Bengaluru',
  );

  bool _loading = false;

  String? _errorMessage;

  double? _averageMarketPrice;
  double? _highestMarketPrice;
  double? _aiPredictedPrice;
  double? _recommendedSellingPrice;

  String? _recommendation;
  int? _marketsAnalyzed;

  // Phase 16 recommendation data
  String? _recommendedMarket;
  String? _marketLocation;
  double? _marketPrice;
  double? _estimatedRevenue;

  Future<void> _generateRecommendation() async {
    final quantity =
        double.tryParse(_quantityController.text.trim());

    if (quantity == null || quantity <= 0) {
      setState(() {
        _errorMessage =
            'Please enter a valid quantity in kg.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final location =
          _locationController.text.trim();

      // ------------------------------------------
      // 1. AI PRICE PREDICTION
      // ------------------------------------------
      final priceResult =
          await AiPriceService.predictPrice(
        cropName: _crop,
        location: location,
        quantity: quantity,
      );

      if (!priceResult.success) {
        if (!mounted) return;

        setState(() {
          _loading = false;
          _errorMessage =
              'No market price data found for $_crop.';
        });
        return;
      }

      // ------------------------------------------
      // 2. BEST MARKET RECOMMENDATION
      // ------------------------------------------
      final marketResult =
          await RecommendationService.getRecommendation(
        cropName: _crop,
        location: location,
        quantity: quantity,
      );

      if (!mounted) return;

      if (!marketResult.success) {
        setState(() {
          _loading = false;
          _errorMessage =
              'Market recommendation could not be generated.';
        });
        return;
      }

      setState(() {
        _loading = false;

        // AI prediction
        _averageMarketPrice =
            priceResult.averageMarketPrice;

        _highestMarketPrice =
            priceResult.highestMarketPrice;

        _aiPredictedPrice =
            priceResult.aiPredictedPrice;

        _recommendedSellingPrice =
            priceResult.recommendedSellingPrice;

        _recommendation =
            priceResult.recommendation;

        _marketsAnalyzed =
            priceResult.marketsAnalyzed;

        // Recommendation engine
        _recommendedMarket =
            marketResult.recommendedMarket;

        _marketLocation =
            marketResult.marketLocation;

        _marketPrice =
            marketResult.marketPrice;

        _estimatedRevenue =
            marketResult.estimatedRevenue;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _errorMessage =
            'Unable to connect to the AI service. '
            'Make sure the backend is running.';
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Price Recommendation',
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            color: Colors.green.shade50,
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'AI analyzes available market prices '
                      'and recommends the best market and '
                      'selling opportunity for your crop.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          DropdownButtonFormField<String>(
            initialValue: _crop,
            decoration: const InputDecoration(
              labelText: 'Crop',
              prefixIcon: Icon(Icons.eco),
              border: OutlineInputBorder(),
            ),
            items: marketPrices
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.crop,
                    child: Text(item.crop),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _crop = value;
                });
              }
            },
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Example: Bengaluru',
              prefixIcon:
                  Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _quantityController,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Quantity',
              suffixText: 'kg',
              prefixIcon:
                  Icon(Icons.inventory_2_outlined),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed:
                  _loading
                      ? null
                      : _generateRecommendation,
              icon: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.auto_awesome,
                    ),
              label: Text(
                _loading
                    ? 'Analyzing Markets...'
                    : 'Generate Recommendation',
              ),
            ),
          ),

          if (_errorMessage != null) ...[
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Text(
                  _errorMessage!,
                  style:
                      const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],

          // ==========================================
          // AI PRICE ANALYSIS
          // ==========================================
          if (_recommendedSellingPrice != null) ...[
            const SizedBox(height: 25),

            const Text(
              'AI Price Analysis',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _priceCard(
              'Average Market Price',
              _averageMarketPrice!,
              Icons.analytics_outlined,
            ),

            _priceCard(
              'Highest Market Price',
              _highestMarketPrice!,
              Icons.trending_up,
            ),

            _priceCard(
              'AI Predicted Price',
              _aiPredictedPrice!,
              Icons.auto_awesome,
            ),

            _priceCard(
              'Recommended Selling Price',
              _recommendedSellingPrice!,
              Icons.sell_outlined,
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding:
                    const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Recommendation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      _recommendation ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),

                    if (_marketsAnalyzed != null) ...[
                      const SizedBox(height: 10),

                      Text(
                        'Markets analyzed: '
                        '$_marketsAnalyzed',
                        style: TextStyle(
                          color:
                              Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],

          // ==========================================
          // BEST MARKET
          // ==========================================
          if (_recommendedMarket != null) ...[
            const SizedBox(height: 28),

            const Text(
              'Best Market Recommendation',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 32,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Recommended Market',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _recommendedMarket!,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _marketLocation ?? '',
                          style:
                              const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Divider(),

                    const SizedBox(height: 12),

                    _recommendationRow(
                      'Market Price',
                      '₹${_marketPrice!.toStringAsFixed(2)} / kg',
                    ),

                    const SizedBox(height: 12),

                    _recommendationRow(
                      'Your Quantity',
                      '${quantityControllerValue()} kg',
                    ),

                    const SizedBox(height: 12),

                    _recommendationRow(
                      'Expected Revenue',
                      '₹${_estimatedRevenue!.toStringAsFixed(2)}',
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(14),
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(12),
                        color: Colors.green.shade50,
                      ),
                      child: const Text(
                        'This market currently offers '
                        'the highest available price '
                        'for your selected crop.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String quantityControllerValue() {
    final quantity =
        double.tryParse(
          _quantityController.text.trim(),
        ) ??
        0;

    return quantity.toStringAsFixed(0);
  }

  Widget _priceCard(
    String title,
    double price,
    IconData icon,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green.shade700,
          size: 30,
        ),
        title: Text(
          title,
          style:
              const TextStyle(
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          '₹${price.toStringAsFixed(2)} / kg',
          style: TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.bold,
            color:
                Colors.green.shade700,
          ),
        ),
      ),
    );
  }

  Widget _recommendationRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style:
              const TextStyle(
            fontSize: 17,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
// ============================================================
// SEED SHOPS
// ============================================================

class SeedShopsScreen
    extends StatelessWidget {
  const SeedShopsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ShopFinderScreen();
  }
}

// ============================================================
// NOTIFICATIONS
// ============================================================

class NotificationsScreen
    extends StatelessWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notifications = [
      (
        Icons.auto_awesome,
        'AI price recommendation ready',
        'Your latest crop can be reviewed.',
      ),
      (
        Icons.shopping_cart_outlined,
        'New buyer interest',
        'A buyer is interested in your listed crop.',
      ),
      (
        Icons.trending_up,
        'Market update',
        'Onion prices are showing an upward trend.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
        backgroundColor:
            Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(14),
        children: [
          ...notifications.map(
            (notification) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.green.shade100,
                  child: Icon(
                    notification.$1,
                  ),
                ),
                title: Text(
                  notification.$2,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  notification.$3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BUYER REQUESTS
// ============================================================

class BuyerRequestsScreen
    extends StatelessWidget {
  const BuyerRequestsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'My Requests',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        const _EmptyState(
          icon:
              Icons.shopping_bag_outlined,
          title: 'No requests yet',
          message:
              'When you request a crop, it will appear here.',
        ),
      ],
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfileScreen
    extends StatelessWidget {
  final String role;

  const ProfileScreen({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 10),

        CircleAvatar(
          radius: 48,
          backgroundColor:
              Colors.green.shade100,
          child: Text(
            role == 'Farmer'
                ? '👨‍🌾'
                : '🛒',
            style: const TextStyle(
              fontSize: 42,
            ),
          ),
        ),

        const SizedBox(height: 14),

        Center(
          child: Text(
            'Local $role',
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 25),

        _SettingsTile(
          icon: Icons.person_outline,
          title: 'Account Details',
          onTap: () {},
        ),

        _SettingsTile(
          icon: Icons.language,
          title: 'Language',
          onTap: () {},
        ),

        _SettingsTile(
          icon:
              Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const NotificationsScreen(),
              ),
            );
          },
        ),

        _SettingsTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {},
        ),

        _SettingsTile(
          icon: Icons.info_outline,
          title: 'About Crop\'D UP',
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName:
                  "Crop'D UP",
              applicationVersion: 'MVP',
              applicationLegalese:
                  'Connecting farmers and buyers.',
            );
          },
        ),
      ],
    );
  }
}

// ============================================================
// REUSABLE WIDGETS
// ============================================================

class _GreetingCard
    extends StatelessWidget {
  final String name;
  final String subtitle;
  final String icon;

  const _GreetingCard({
    required this.name,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade800,
            Colors.green.shade600,
          ],
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 40,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, $name',
                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style:
                      const TextStyle(
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard
    extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(17),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  Colors.green.shade700,
              size: 28,
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style:
                      const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CROP CARD
// ============================================================

class CropCard
    extends StatelessWidget {
  final CropListing crop;
  final bool showFarmer;
  final VoidCallback? onTap;

  const CropCard({
    super.key,
    required this.crop,
    required this.showFarmer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12),
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration:
                    BoxDecoration(
                  color:
                      Colors.green.shade100,
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
                child: Center(
                  child: Text(
                    _cropEmoji(
                      crop.name,
                    ),
                    style:
                        const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      crop.name,
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '${crop.quantity} kg • '
                      '₹${crop.price}/kg',
                      style: TextStyle(
                        color:
                            Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '📍 ${crop.location}',
                      style: TextStyle(
                        color:
                            Colors.grey.shade700,
                      ),
                    ),

                    if (showFarmer) ...[
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '👨‍🌾 ${crop.farmer}',
                        style: TextStyle(
                          color:
                              Colors.grey.shade700,
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration:
                              BoxDecoration(
                            color: crop.available
                                ? Colors.green
                                    .shade50
                                : Colors.grey
                                    .shade200,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              20,
                            ),
                          ),
                          child: Text(
                            crop.available
                                ? 'Available'
                                : 'Sold',
                            style:
                                TextStyle(
                              color: crop.available
                                  ? Colors.green
                                      .shade800
                                  : Colors.grey
                                      .shade700,
                              fontSize: 12,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),

                        const Spacer(),

                        if (onTap != null)
                          const Icon(
                            Icons
                                .arrow_forward_ios,
                            size: 15,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TOOL TILE
// ============================================================

class _ToolTile
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ToolTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: CircleAvatar(
          backgroundColor:
              Colors.green.shade100,
          child: Icon(
            icon,
            color:
                Colors.green.shade800,
          ),
        ),
        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// SETTINGS TILE
// ============================================================

class _SettingsTile
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 9,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              Colors.green.shade700,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// DETAIL ROW
// ============================================================

class _DetailRow
    extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color:
              Colors.green.shade700,
        ),
        title: Text(
          label,
          style: TextStyle(
            color:
                Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY CHIP
// ============================================================

class _CategoryChip
    extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(
        right: 8,
      ),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _EmptyState
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 50,
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 65,
            color:
                Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style:
                const TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            message,
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color:
                  Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HELPERS
// ============================================================

String _cropEmoji(String crop) {
  final value = crop.toLowerCase();

  if (value.contains('tomato')) {
    return '🍅';
  }

  if (value.contains('onion')) {
    return '🧅';
  }

  if (value.contains('potato')) {
    return '🥔';
  }

  if (value.contains('rice')) {
    return '🌾';
  }

  if (value.contains('wheat')) {
    return '🌾';
  }

  if (value.contains('apple')) {
    return '🍎';
  }

  if (value.contains('banana')) {
    return '🍌';
  }

  if (value.contains('mango')) {
    return '🥭';
  }

  return '🌱';
}
