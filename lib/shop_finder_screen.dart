import 'package:flutter/material.dart';

import 'shop_service.dart';

class ShopFinderScreen extends StatefulWidget {
  const ShopFinderScreen({super.key});

  @override
  State<ShopFinderScreen> createState() => _ShopFinderScreenState();
}

class _ShopFinderScreenState extends State<ShopFinderScreen> {
  final ShopService _shopService = ShopService();

  final TextEditingController _searchController =
      TextEditingController();

  List<Shop> _allShops = [];
  List<Shop> _filteredShops = [];

  String _selectedCategory = 'All';
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _categories = const [
    'All',
    'Seeds',
    'Fertilizers',
    'Agriculture Tools',
    'Farming Supplies',
    'Plant Protection',
  ];

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadShops() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final shops = await _shopService.getShops();

      if (!mounted) return;

      setState(() {
        _allShops = shops;
        _filteredShops = shops;
        _isLoading = false;
      });

      _applyFilters();
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to load shops.\n$error';
      });
    }
  }

  void _applyFilters() {
    final searchText = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredShops = _allShops.where((shop) {
        final matchesSearch =
            searchText.isEmpty ||
            shop.name.toLowerCase().contains(searchText) ||
            shop.location.toLowerCase().contains(searchText) ||
            shop.category.toLowerCase().contains(searchText);

        final matchesCategory =
            _selectedCategory == 'All' ||
            shop.category.toLowerCase() ==
                _selectedCategory.toLowerCase();

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onSearchChanged(String value) {
    _applyFilters();
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });

    _applyFilters();
  }

  Future<void> _showShopDetails(Shop shop) async {
    List<ShopProduct>? products;
    String? productError;
    bool isLoadingProducts = true;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            if (isLoadingProducts) {
              _loadProductsForSheet(
                shop.id,
                (loadedProducts) {
                  if (!context.mounted) return;

                  setSheetState(() {
                    products = loadedProducts;
                    isLoadingProducts = false;
                  });
                },
                (error) {
                  if (!context.mounted) return;

                  setSheetState(() {
                    productError = error;
                    isLoadingProducts = false;
                  });
                },
              );
            }

            return Container(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height * 0.85,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    12,
                    20,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 45,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                Colors.green.shade100,
                            child: Icon(
                              Icons.store,
                              color: Colors.green.shade700,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shop.name,
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  shop.category,
                                  style: TextStyle(
                                    color:
                                        Colors.green.shade700,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      _infoRow(
                        Icons.location_on_outlined,
                        'Location',
                        shop.location,
                      ),

                      const SizedBox(height: 10),

                      _infoRow(
                        Icons.phone_outlined,
                        'Contact',
                        shop.contact,
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2_outlined,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Products & Availability',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      if (isLoadingProducts)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (productError != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade700,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Could not load products.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                productError!,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton.icon(
                                onPressed: () {
                                  setSheetState(() {
                                    isLoadingProducts = true;
                                    productError = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                ),
                                label: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      else if (products == null ||
                          products!.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: const Column(
                            children: [
                              Icon(
                                Icons.inventory_outlined,
                                size: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'No products listed yet.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ...products!.map(
                          (product) =>
                              _productCard(product),
                        ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);

                            ScaffoldMessenger.of(
                              this.context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Contact ${shop.name} at '
                                  '${shop.contact}',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.phone,
                          ),
                          label: const Text(
                            'Contact Shop',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _loadProductsForSheet(
    int shopId,
    void Function(List<ShopProduct>) onSuccess,
    void Function(String) onError,
  ) async {
    try {
      final products =
          await _shopService.getShopProducts(shopId);

      onSuccess(products);
    } catch (error) {
      onError(error.toString());
    }
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 21,
          color: Colors.green.shade700,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _productCard(ShopProduct product) {
    final available = product.availability;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: available
          ? Colors.green.shade50
          : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: available
                    ? Colors.green.shade100
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: available
                    ? Colors.green.shade700
                    : Colors.grey.shade600,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹${product.price}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: available
                    ? Colors.green.shade100
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                available ? 'Available' : 'Out of stock',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: available
                      ? Colors.green.shade800
                      : Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search shop, location or category',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                      _applyFilters();
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, _) =>
                const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final selected =
                  category == _selectedCategory;

              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) {
                  _selectCategory(category);
                },
                selectedColor: Colors.green.shade100,
                labelStyle: TextStyle(
                  color: selected
                      ? Colors.green.shade800
                      : Colors.grey.shade800,
                  fontWeight: selected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShopCard(Shop shop) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showShopDetails(shop),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  Icons.storefront_outlined,
                  color: Colors.green.shade700,
                  size: 29,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            shop.location,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        shop.category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 55,
                color: Colors.grey.shade600,
              ),
              const SizedBox(height: 16),
              const Text(
                'Unable to connect to Crop\'D UP',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Make sure the backend server is running.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _loadShops,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadShops,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Find Agriculture Shops 🌱',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Check products, prices and availability '
            'before you travel.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          _buildSearchAndFilters(),

          const SizedBox(height: 20),

          if (_filteredShops.isEmpty)
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.store_mall_directory_outlined,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No shops found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Try another search or category.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ..._filteredShops.map(_buildShopCard),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop Finder',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _loadShops,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
}