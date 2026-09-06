import 'package:flutter/material.dart';

void main() {
  runApp(const CropDUpApp());
}

// ============================================================
// MODEL
// ============================================================

class CropListing {
  final String name;
  final String quantity;
  final String price;
  final String location;

  CropListing({
    required this.name,
    required this.quantity,
    required this.price,
    required this.location,
  });
}

// Temporary in-memory storage.
// Later we will replace this with a real backend/database.
final List<CropListing> cropListings = [
  CropListing(
    name: "Tomato",
    quantity: "500",
    price: "27",
    location: "Bengaluru",
  ),
];

// ============================================================
// APP
// ============================================================

class CropDUpApp extends StatelessWidget {
  const CropDUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crop'D UP",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorSchemeSeed: Colors.green,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ============================================================
// WELCOME SCREEN
// ============================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.green.shade100,
                    ),
                    child: const Center(
                      child: Text(
                        '🌾',
                        style: TextStyle(fontSize: 52),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // App name
                  const Text(
                    "CROP'D UP",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Better prices. Better choices.\n'
                    'More power to farmers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 45),

                  // Farmer button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FarmerDashboard(),
                          ),
                        );
                      },
                      icon: const Text(
                        '👨‍🌾',
                        style: TextStyle(fontSize: 24),
                      ),
                      label: const Text(
                        "I'm a Farmer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Buyer button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Buyer section coming next!",
                            ),
                          ),
                        );
                      },
                      icon: const Text(
                        '🛒',
                        style: TextStyle(fontSize: 24),
                      ),
                      label: const Text(
                        "I'm a Buyer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green.shade800,
                        side: BorderSide(
                          color: Colors.green.shade700,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Language
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.language),
                    label: const Text(
                      'English  ▾',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// FARMER DASHBOARD
// ============================================================

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() =>
      _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  Future<void> _openAddCrop() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCropScreen(),
      ),
    );

    // Refresh dashboard after adding a crop.
    if (result == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmer Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome, Farmer 👨‍🌾",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Manage your crops and discover better prices.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 25),

            // Add crop button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _openAddCrop,
                icon: const Icon(Icons.add),
                label: const Text(
                  "Add My Crop",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "My Crop Listings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // =================================================
            // DYNAMIC CROP LIST
            // =================================================

            if (cropListings.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "No crop listings yet.\nAdd your first crop!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              )
            else
              ...cropListings.map(
                (crop) => _CropCard(crop: crop),
              ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.trending_up,
                    title: "Market Prices",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Market Prices feature coming next!",
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _ActionCard(
                    icon: Icons.store,
                    title: "Seed Shops",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Seed Shops feature coming next!",
                          ),
                        ),
                      );
                    },
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

class _CropCard extends StatelessWidget {
  final CropListing crop;

  const _CropCard({
    required this.crop,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🌱 ${crop.name}",
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Quantity: ${crop.quantity} kg",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 4),

            Text(
              "Your price: ₹${crop.price}/kg",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 4),

            Text(
              "Location: ${crop.location}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              "AI suggested: ₹25–₹27/kg",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: Colors.green.shade600,
                ),
                const SizedBox(width: 6),
                const Text("Available"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// QUICK ACTION CARD
// ============================================================

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Icon(
                icon,
                size: 36,
                color: Colors.green.shade700,
              ),

              const SizedBox(height: 10),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
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
// ADD CROP SCREEN
// ============================================================

class AddCropScreen extends StatefulWidget {
  const AddCropScreen({super.key});

  @override
  State<AddCropScreen> createState() =>
      _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cropController =
      TextEditingController();

  final TextEditingController _quantityController =
      TextEditingController();

  final TextEditingController _priceController =
      TextEditingController();

  final TextEditingController _locationController =
      TextEditingController();

  @override
  void dispose() {
    _cropController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // ==========================================================
  // ADD LISTING
  // ==========================================================

  void _addListing() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ACTUALLY SAVE THE CROP
    cropListings.add(
      CropListing(
        name: _cropController.text.trim(),
        quantity: _quantityController.text.trim(),
        price: _priceController.text.trim(),
        location: _locationController.text.trim(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Crop listing added successfully! 🌱",
        ),
      ),
    );

    // Return to Farmer Dashboard
    Future.delayed(
      const Duration(milliseconds: 600),
      () {
        if (mounted) {
          Navigator.pop(context, true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add My Crop",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Create a Crop Listing 🌱",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Enter the details of the crop you want to sell.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 25),

              // Crop name
              TextFormField(
                controller: _cropController,
                decoration: InputDecoration(
                  labelText: "Crop Name",
                  hintText: "Example: Tomato",
                  prefixIcon:
                      const Icon(Icons.eco),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter the crop name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              // Quantity
              TextFormField(
                controller: _quantityController,
                keyboardType:
                    TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantity",
                  hintText: "Example: 500",
                  prefixIcon:
                      const Icon(Icons.inventory_2),
                  suffixText: "kg",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter the quantity";
                  }

                  final number =
                      double.tryParse(value);

                  if (number == null) {
                    return "Enter a valid number";
                  }

                  if (number <= 0) {
                    return "Quantity must be greater than 0";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // Price
              TextFormField(
                controller: _priceController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: "Expected Price",
                  hintText: "Example: 27",
                  prefixIcon:
                      const Icon(Icons.currency_rupee),
                  suffixText: "per kg",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter your expected price";
                  }

                  final number =
                      double.tryParse(value);

                  if (number == null) {
                    return "Enter a valid price";
                  }

                  if (number <= 0) {
                    return "Price must be greater than 0";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  hintText: "Example: Bengaluru",
                  prefixIcon:
                      const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter the location";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Add Listing button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: _addListing,
                  icon: const Icon(Icons.check),
                  label: const Text(
                    "Add Listing",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}